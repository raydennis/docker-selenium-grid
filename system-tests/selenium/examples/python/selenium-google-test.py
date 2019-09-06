# import time
import unittest
import os

from selenium import webdriver
from selenium.webdriver.common.keys import Keys


class UnmEDUTest(unittest.TestCase):

    def setUp(self):
        # uncomment the webdriver.Chrome() line, and comment out the next 5,
        # if you would like to run against your local chromedriver
        # self.browser = webdriver.Chrome()
        caps = {'browserName': os.getenv('BROWSER', 'chrome')}
        self.browser = webdriver.Remote(
            command_executor='http://localhost:4444/wd/hub',
            desired_capabilities=caps
        )

    def test_unmedu_search_for_unmit(self):
        browser = self.browser
        browser.get('http://www.google.com')
        search_box = browser.find_element_by_name('q')
        search_box.send_keys('UNM-IT')
        search_box.send_keys(Keys.RETURN)
        # time.sleep(3)  # simulate long running test
        self.assertIn('UNM-IT', browser.page_source)

    def test_unmedu_search_for_duante_arruti(self):
        browser = self.browser
        browser.get('http://www.google.com')
        search_box = browser.find_element_by_name('q')
        search_box.send_keys('Duane Arruti')
        search_box.send_keys(Keys.RETURN)
        # time.sleep(3)  # simulate long running test
        self.assertIn('Duane Arruti', browser.page_source)

    def tearDown(self):
        self.browser.quit()  # quit vs close?


if __name__ == '__main__':
    unittest.main()
