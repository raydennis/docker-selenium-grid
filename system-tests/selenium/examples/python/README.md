This test assumes you have a working chrome driver.
You can get one [here](https://unmit.visualstudio.com/_git/docker-selenium-grid)
or [here](https://sites.google.com/a/chromium.org/ChromeDriver/).

1. Create and activate a virtual environment.
```bash
python3 -m venv ~/.virtualenvs/selenium
source ~/.virtualenvs/selenium/bin/activate
```
2. Install Selenium: 
```bash
pip install selenium==3.141.0
```
3. Ensure it works: 
```bash
python selenium-google-test.py
```

You can also specify a specific browser:
```bash
export BROWSER=chrome && python test.py
export BROWSER=firefox && python test.py
```
