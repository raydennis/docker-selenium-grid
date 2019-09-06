echo "get versions"
make --version
python --version

echo "build containers"
pwd
make help
make docker-build
make docker-test

echo "setup python environment"
cd system-tests/selenium/examples/python
pwd
python3 -m venv env
source env/bin/activate
pip3 install selenium==3.141.0

echo "run python example test"
python3 selenium-google-test.py
