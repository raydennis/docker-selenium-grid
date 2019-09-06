package com.example;

import java.net.MalformedURLException;
import java.net.URL;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.GeckoDriverService;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class example {

    public static void main(String[] args) throws Exception {
//        WebDriver driver = new ChromeDriver();
        WebDriver driver = new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"),
            DesiredCapabilities.chrome());

        String baseUrl = "http://www.unm.edu";
        String expectedTitle = "New Mexico's Flagship University";
        String actualTitle = "";

        // launch browser and direct it to the Base URL
        driver.get(baseUrl);

        // get the actual value of the title
        actualTitle = driver.getTitle();

        /*
         * compare the actual title of the page with the expected one and print
         * the result as "Passed" or "Failed"
         */
        if (actualTitle.contains(expectedTitle)){
            System.out.println("Test Passed!");
        } else {
            System.out.println("Test Failed");
        }

        //close browser
        driver.close();

    }
}
