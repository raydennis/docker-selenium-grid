echo "get versions"
make --version
python3 --version

echo "build containers"
make docker-build

echo "setup python environment"
pip3 install selenium==3.141.0

echo "run python example test"
python3 system-tests/selenium/examples/python/selenium-google-test.py
