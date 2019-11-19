*** Settings ***
Library    SeleniumLibrary
Library    XvfbRobot

*** Test Cases ***
Search TUNI from Google
    Start Virtual Display    1920    1080
    Open Browser    https://www.google.com/    firefox
    Set Window Size    1920    1080
    Input Text xpath://input[@title='search']   TUNI
    Click Button xpath://input[@value='Google Search']
    Capture Page Screenshot    firefox_1920_1080.png
    [Teardown]    Close BROWSER
