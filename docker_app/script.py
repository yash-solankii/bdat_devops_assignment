import pandas as pd

df = pd.read_csv('data.csv')

print("Average value:", df['Price'].mean())
print("Max:", df['Price'].max())
print("Min:", df['Price'].min())
