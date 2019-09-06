# Welcome

## Get started by

1. clone this repo

2. bring up the containers 
```
make docker-build
```

## Resources

Console: http://127.0.0.1:4444/grid/console

Status: http://127.0.0.1:4444/wd/hub/status

In order to point to the Selenium Grid, you will need the following definitions in your test:  
```java
WebDriver driver = new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"),
        DesiredCapabilities.chrome());
```


```python
caps = {'browserName': os.getenv('BROWSER', 'chrome')}
self.browser = webdriver.Remote(
        command_executor='http://localhost:4444/wd/hub',
        desired_capabilities=caps
        )
```

## There are example tests in the "system-tests" folder.

## Happy testing!
