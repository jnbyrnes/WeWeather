# Weather Forecast Web App

This app utilizes the (http://www.wunderground.com/weather/api/d/docs) API to retrieve and present weather data for a given zip code. It presents current conditions and three day forecast. 
The hourly forecast functionality was not able to be completed in the given time.

-------------------

### Dependencies

* App was built in ruby (1.9.3p125) and rails (3.2.11)
* App utilized mongodb and mongoid

-------------------

### Considerations

* User enters in zip code in navbar search and the current forecast is returned
* Zip Code is saved in session for use in other tabs or when return to page
* API request is made as part of user request
* If there is a record for the zip code in the last hour, then that record is used instead of hitting the API

-------------------

### Improvements

* Implementation of the hourly forecast, which can be extrapolated from the existing model and the code for the current and three day forecasts
* API request should not be a blocking part of user request. API request should be moved to asynchronous processing, such as delayed job. AJax should be used to return immediately with html partial
displaying something to the effect of updating. When the response is received it should be updated without page reload via AJax, with the result page.
