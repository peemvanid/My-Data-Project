# -*- coding: utf-8 -*-

# -- Project --

# # Project - Analyzing Sales Data
# **Date**: 10 September 2022


# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# shape of dataframe
df.shape

# preview top 5 rows
df.head()

# see data frame information using .info()
df.info()

# ## Prepare Dataframe


# ### Clean columns name


# clean columns name
    # 1. make it lower case
    # 2. replace " " with "_"
    # 3. assign clean column name back to df

col_names = list(df.columns)

clean_col_names = []

for name in col_names:
    temp = name.lower().replace(" ", "_").replace("/", "_").replace("-", "_")
    clean_col_names.append(temp)

df.columns = clean_col_names
df.head(2)

# ### Covert Datetime


# We can use `pd.to_datetime()` function to convert columns 'Order Date' and 'Ship Date' to datetime.


# TODO - convert order date and ship date to datetime in the original dataframe

df['order_date'] = pd.to_datetime(df['order_date'])
df['ship_date'] = pd.to_datetime(df['ship_date'])

#df['order_date'] = df['order_date'].dt.date
#df['ship_date'] = df['ship_date'].dt.date

df[['order_date', 'ship_date']].head()

# ### Split Year


# split Year from column 'order_date' to make it easily to work with Year

df['order_year'] = df['order_date'].dt.year

df[['row_id', 'order_date', 'order_year']].head()

# ### Check missing values


# TODO - count nan in postal code column

df['postal_code'].isna().sum()

# TODO - filter rows with missing values

df[df.isna().any(axis=1)].head()

# ## Explore this dataset on your owns, ask your own questions


# TODO - Explore this dataset on your owns, ask your own questions

# Propotion of total sales (%) by Segment overtime (2017-2020)

# prepare Dataframe
sales_segment = df.groupby('segment')['sales'].sum().reset_index()

# calculate percent proprotion and Mutate column 'total_sales_%'
sales_segment['total_sales_%'] = (sales_segment['sales']\
                               /sales_segment['sales'].sum() *100)\
                                .round(2)

# plot chart
sales_segment.set_index('segment', inplace=True)

sales_segment.plot.pie(y='total_sales_%', figsize=(7.5, 7.5),\
                       autopct='%1.1f%%', explode=(0, 0.0, 0.1),\
                       colors = ['deepskyblue', 'aquamarine', 'salmon'],\
                       shadow=True, startangle=0, ylabel='Sales Propotion',\
                       title='Propotion of total sales (%) by Segment overtime (2017-2020)')

# TODO - Explore this dataset on your owns, ask your own questions

# 10 Products that made least profit from Texas in 2020

# prepare texes data
df_tx_2020 = df.query("state == 'Texas' and order_year == 2020")

# explore and plot
df_tx_2020.groupby(['product_name'])[['sales','profit']]\
    .sum().round(2)\
    .sort_values('profit', ascending=True)\
    .reset_index()\
    .rename(columns={'profit': 'loss'})\
    .head(10)\
    .plot(kind='barh', x='product_name',\
          color={'sales': 'navy', 'loss': 'orangered'},\
          title='Comparison of Sales and Loss in top bottom 10 products from Texas in 2020')\
    .invert_yaxis()

# ## Data Analysis Part
# 
# Answer 10 below questions to get credit from this course. Write `pandas` code to find answers.


# ### Question 01


# **How many columns, rows in this dataset?**


# TODO 01 - how many columns, rows in this dataset

print(len(df)) # rows
print(len(df.columns)) # columns

# ### Question 02 


# **Is there any missing values?, if there is, which colunm? how many nan values?**


# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?

df.isna().sum()

# ### Question 03


# **Your friend ask for `California` data, filter it and export csv for your friend**


# TODO 03 - your friend ask for `California` data, filter it and export csv for your friend

df_california = df.query("state == 'California'")

# write 'df_california' to csv file
df_california.to_csv("df_california.csv")

# preview
df_california.head(3)

# ### Question 04


# **Your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send your friend csv file**


# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send your friend csv file

df_ca_tx = df.query("state == 'California' | state == 'Texas'")

ca_tx_2017 = df_ca_tx[(df_ca_tx['order_date'] >= '2017-01-01') \
                      & (df_ca_tx['order_date'] <= '2017-12-31')]


# write 'ca_tx_2017' to csv file
ca_tx_2017.to_csv("df_california_texas_2017.csv")

# preview
ca_tx_2017.head(3)
        

# ### Question 05


# **How much total sales, average sales, and standard deviation of sales your company made in 2017**


# TODO 05 - how much total sales, average sales, and standard deviation of sales your company made in 2017


sales_by_year = df.groupby('order_year')['sales']\
    .agg(['sum', 'mean', 'std'])\
    .rename(columns={'sum': 'total_sales', 'mean': 'avg_sales', 'std': 'SD'})\
    .reset_index()

sales_by_year[(sales_by_year['order_year'] == 2017)]


#sales_by_year.query("order_year == [2017, 2019]")

# ### Question 06


# **: Which Segment has the highest profit in 2018?**


# TODO 06 - which Segment has the highest profit in 2018?

profit_by_seg = df.groupby(['segment','order_year'])['profit']\
    .agg(['sum'])\
    .sort_values('sum', ascending=False)\
    .rename(columns={'sum': 'total_profit'})\
    .reset_index()

profit_by_seg[(profit_by_seg['order_year'] == 2018)]

# ### Question 07


# **Which top 5 States have the least total sales between 15 April 2019 - 31 December 2019**


# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019

df_apr15_to_dec31_2019 = df[(df['order_date'] >= '2019-04-15')\
                        & (df['order_date'] <= '2019-12-31') ]

bottom5_state_sales_2019 = df_apr15_to_dec31_2019.groupby(['state'])['sales']\
    .agg(['sum'])\
    .sort_values('sum', ascending=True)\
    .rename(columns={'sum': 'total_sales'})\
    .reset_index()\
    .head(5)

bottom5_state_sales_2019

# ### Question 08


# **What is the proportion of total sales (%) in West + Central in 2019 e.g. 25%**


# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25%

df_2019 = df.query("order_year == 2019")\
    .rename(columns={'sales': 'sales_2019'})

# group by region
df_2019_region = df_2019.groupby('region')['sales_2019'].sum().round(2)\
    .reset_index()

# calculate percentage
df_2019_region['total_sales_%'] = ((df_2019_region['sales_2019'])\
                               /df_2019_region['sales_2019'].sum() *100)\
                                .round(2)       


# review a all region total sales (%) in 2019
df_2019_region

# calculate proportion of total sales (%) in West + Central in 2019

CenWest2019_prop = df_2019_region.query("region == ['Central', 'West']").sum()

CenWest2019_prop['total_sales_%']

# 54.97 %

# ### Question 09
#  


# **Find top 10 popular products in terms of number of orders vs. total sales during 2019-2020**


# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020

# prapare data from 2019-2020
df_2019_2020 = df.query("order_year == [2019, 2020]")


# find top 10 popular products in terms of number of orders (2019-2020)
top10_order_2019_2020 = df_2019_2020.groupby(['product_name'])['row_id'].count()\
    .sort_values(ascending=False)\
    .reset_index()\
    .head(10)\
    .rename(columns={'row_id': 'number_of_orders'})\
    
top10_order_2019_2020.head()

# find top 10 popular products in terms of total quantity (2019-2020)

top10_quantity_2019_2020 = df_2019_2020.groupby(['product_name'])['quantity']\
    .sum().round(2)\
    .sort_values(ascending=False)\
    .reset_index()\
    .head(10)\
    .rename(columns={'quantity': 'total_quantity'})\
    
top10_quantity_2019_2020.head()

# find top 10 popular products in terms of total sales (2019-2020)

top10_sales_2019_2020 = df_2019_2020.groupby(['product_name'])['sales']\
    .sum().round(2)\
    .sort_values(ascending=False)\
    .reset_index()\
    .head(10)\
    .rename(columns={'sales': 'total_sales'})\
    
top10_sales_2019_2020.head()

# create compare table to easily to compare between two top10 from number of orders, quantity and sales

compare_top10 = pd.concat([top10_order_2019_2020,\
                           top10_quantity_2019_2020,\
                           top10_sales_2019_2020], axis=1)

compare_top10

# ### Question 10


# **Plot at least 2 plots, any plot you think interesting :)**


# TODO 10 - plot at least 2 plots, any plot you think interesting :)

# Comparison of Sales and Profit during 2019-202 by State (Top 10)

state_SalesPro_plt = df_2019_2020.groupby('state')[['sales', 'profit']].sum()\
    .sort_values('sales', ascending=False)\
    .reset_index()\
    .head(10)\
    .plot(x='state', kind='bar', xlabel='State',\
          color = {'sales':'darkorchid', 'profit': 'coral'},figsize=(10, 9),\
          title='Comparison of Sales and Profit during 2019-2020 by State (Top 10)')

state_SalesPro_plt

# Comparison of Sales and Profit from Texas

tx_plt = df.groupby(['state', 'order_year'])[['sales', 'profit']].sum()\
    .query("state == 'Texas'")\
    .reset_index()\
    .plot(x='order_year', y=['sales', 'profit'],kind='bar', rot=0, xlabel='Year',\
          color={'sales':'rebeccapurple', 'profit': 'coral'},figsize=(10, 6),\
          title='Comparison of Sales and Profit from Texas')

tx_plt

# The 10 Hightest Profit made by State in 2020

pro_2020 = df.query("order_year == 2020")\
    .groupby('state')['profit'].sum().round(2)\
    .sort_values(ascending=False)\
    .reset_index()\
    .head(10)\
    .plot(x='state', y='profit', kind='barh', xlabel='State',\
          color='mediumaquamarine', figsize=(7.5, 5),
          title='The 10 Hightest Profit made by State in 2020')\
    .invert_yaxis()

pro_2020

# ### Bonus - np.where


# **Use np.where() to create new column in dataframe to help you answer your own questions**


# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions

# Times that product was sold with discount over 2018-2020

import numpy as np

# mutate 'use_discount' column
df['use_discount'] = np.where(df['discount'] > 0.0, True, False)

# explore the data and plot results in Top 10
df.query("use_discount == True")\
    .groupby('product_name')['use_discount']\
    .count().sort_values(ascending=False)\
    .reset_index()\
    .head(10)\
    .plot(kind='barh', x='product_name', xlabel='Product', color='wheat',\
          title='Times that product was sold with discount over 2018-2020')\
    .invert_yaxis()

