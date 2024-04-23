# if Python packages are installed, add them to $PATH
if [ $(command -v python3) ]; then
    PYTHON_VERSION=$(python3 --version | cut -d" " -f2 | cut -d"." -f "1 2") 
    PATH="$PATH:$HOME/Library/Python/${PYTHON_VERSION}/bin"
fi;

