# publicholidays

## Goal
The goal of `publicholidays` R package is to wrap Nager.Date API and provide valuable holiday insights for various business applications.

## Package Status & Installation

![R Package: GitHub Action CI]()

##### Coverage: 100% - 5 functions total included in the `publicholidays` package ##### 

To explore public holidays information of different countries, simply:

- Install the package via GitHub
- OR archive file and import from library

```
# Install from GitHub
library(remotes)
install_github("Raccoon-he/publicholidays")

# Install from publicholidays file
# install.packages('publicholidays')

# import library
library(publicholidays)
```

## Usage

Once you have completed the steps above, you may utilize the following 5 functions.

>>> ```  
>>> ph_available_countries  
>>> ``` 

This function retrieves a list of all countries for which holiday data is available.

```ph_available_countries()```

```
# Example usage
countries <- ph_available_countries()
print(countries) 
```

The variable `countries` will be a tibble containing the following columns: "countryCode" (the ISO 3166-1 alpha-2 country code), "name" (the name of the country).


>>> ```  
>>> ph_country_info()
>>> ``` 

This funciton retrieves information of specific country, such as common name, official name, and region.

```ph_country_info(country_code)```

- country_code: A string specifying the country code

```
# Example usage
country_info <- ph_country_info("DE")
print(country_info)
```

The variable `country_info` will be a tibble containing the following columns: "commonName" (the common name of the country), "officialName" (the official name of the country), "countryCode" (the ISO 3166-1 alpha-2 country code), "region" (the region where the country is located), "borders" (a list of country codes for countries that share a border with the specified country).


>>> ```  
>>> ph_is_today_holiday()
>>> ``` 

This function is designed to check if today is a public holiday in specific country.

```ph_is_today_holiday(country_code)```

- country_code: A string specifying the country code

```
# Example usage
is_holiday <- ph_is_today_holiday("DE")
if (is_holiday) {
  print("Today is a public holiday in Germany!")
} else {
  print("Today is not a public holiday in Germany.")
}
```

The variable `country_info` will be a logical value. "TRUE" means today is a public holiday in the specified country.


>>> ```  
>>> ph_long_weekends()
>>> ``` 

This function retrieves a list of long weekends (extended weekends due to public holidays) for a specific country and year using the Nager.Date API.

```ph_long_weekends(country_code, year)```

- country_code: A string specifying the country code
- year: A string specifying the year

```
# Example usage
long_weekends <- ph_long_weekends("DE", 2025)
print(long_weekends)
```

The variable `long_weekends` will be a tibble containing the following columns: "startDate" (the start date of the long weekend), "endDate" (the end date of the long weekend), "dayCount" (the number of days in the long weekend), "needBridgeDay" (a logical value indicating whether a bridge day is needed to create the long weekend), "bridgeDays" (A list of bridge days (if any) required to create the long weekend).


>>> ```  
>>> ph_public_holidays()
>>> ``` 

This function retrieves a list of public holidays for a specific country and year using the Nager.Date API.

```ph_public_holidays(country_code, year)```

- country_code: A string specifying the country code
- year: A string specifying the year

```
# Example usage
holidays <- ph_public_holidays("DE", 2025)
print(holidays)
```

The variable `holidays` will be a tibble containing the following columns: "date" (the date of the public holiday), "localName" (the local name of the public holiday), "name" (the English name of the public holiday), "countryCode" (the ISO 3166-1 alpha-2 country code), "fixed" (a logical value indicating whether the public holiday has a fixed date), "global" (a logical value indicating whether the public holiday is observed globally in the country), "countries" (a list of counties or regions where the public holiday is observed), "launchYear" (the year the public holiday was first observed), "types" (a list of types or categories of the public holiday).

**Example of creating a bar plot showing the number of public holidays for each country**

```
# Example usage
# Retrieve the list of supported countries
countries <- ph_available_countries()

# Select a few countries to analyze
selected_countries <- c("DE", "US", "CN", "JP", "FR")

# Initialize a data frame to store the results
holidays_count <- data.frame(
  country_code = character(),
  country_name = character(),
  num_holidays = integer(),
  stringsAsFactors = FALSE
)

# Loop through each selected country and retrieve public holidays
for (country_code in selected_countries) {
  country_name <- countries[countries$countryCode == country_code, "name"]
  holidays <- ph_public_holidays(country_code, 2025)
  num_holidays <- nrow(holidays)
  
  holidays_count <- rbind(holidays_count, data.frame(
    country_code = country_code,
    country_name = country_name,
    num_holidays = num_holidays
  ))
}

# Create a bar plot to visualize the number of public holidays
ggplot(holidays_count, aes(x = reorder(name, num_holidays), y = num_holidays)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Number of Public Holidays in 2025",
       x = "Country",
       y = "Number of Public Holidays") +
  theme(axis.text.x = element_text(hjust = 1))
```

**Example output of the plot**

![example](../img/example.png)

