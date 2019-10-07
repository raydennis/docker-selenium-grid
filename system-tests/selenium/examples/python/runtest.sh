# echo "get versions"
# make --version
# python --version

# echo "get folders"
# pwd
# ls -lha
# echo ".docker"
# ls -lha .docker
# echo "/python"
# ls -lha system-tests/selenium/examples/python 

echo "build containers"
# make help
make docker-build

echo sleep 5s to wait for the hub to identify the nodes
sleep 5s

echo check that the containers built correctly and we have spare capacity
make docker-test

echo "setup python environment"
cd system-tests/selenium/examples/python
pip install selenium==3.141.0

echo "run python example test"
python selenium-google-test.py
