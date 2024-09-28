# -*- coding: utf-8 -*-
"""
Spyder Editor

@author: Jane Tsui
"""

import requests

#available nutritional attributes: calories, fat, sugar, carbohydrates, protein

user_input = input("Enter a fruit to look up, or enter a nutritional attribute and a range (separated by spaces): ")

#look up all fruits with a specified amount of nutrition

if user_input.__contains__(' '):
    user_input_split = user_input.split()
    nutritional = user_input_split[0]
    lower_bound = float(user_input_split[1])
    upper_bound = float(user_input_split[2])

    response = requests.get('https://www.fruityvice.com/api/fruit/all')
    
    fruits = response.json()
    
    for fruit in fruits:
        if lower_bound <= fruit['nutritions'][nutritional] <= upper_bound:
            print(fruit['name'], ": ", fruit['nutritions'][nutritional])

#look up all available info for a specific fruit

else:
    chosen_fruit = user_input 
    response = requests.get(f"https://www.fruityvice.com/api/fruit/{chosen_fruit}")

    print(response.status_code)

    fruit = response.json()

    for key, value in fruit.items():
        print(f"{key}: {value}")