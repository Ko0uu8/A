{ pkgs ? import <nixpkgs> {} }:

{
  jobs.runTelebotPipeline = pkgs.stdenv.mkDerivation {
    name = "run-telebot-pipeline";

    # Define source files
    src = ./.;

    # Build dependencies
    buildInputs = [
      pkgs.python3
      pkgs.python3Packages.pip
      pkgs.coreutils
    ];

    # Prepare dependencies in the build phase
    buildPhase = ''
      echo "Installing Python dependencies..."
      pip3 install pyTelegramBotAPI

      echo "Granting permission to 'venompapa' binary..."
      chmod +x venompapa
    '';

    # Run the script in the install phase
    installPhase = ''
      echo "Running Ven.py..."
      python3 Ven.py
    '';

    # Ensure output is stored in a directory
    installPhase = "mkdir -p $out";
  };
}
