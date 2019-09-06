echo "get versions"
make --version
python --version

sudo apt-get update && sudo apt install -y python3 python3-venv

echo "get folders"
pwd
ls -lha
echo ".docker"
ls -lha .docker
echo "/python"
ls -lha system-tests/selenium/examples/python 

echo "build containers"
make help
make docker-build
make docker-test

echo "setup python environment"
cd system-tests/selenium/examples/python

pip3 install selenium==3.141.0

echo "run python example test"
python3 selenium-google-test.py
