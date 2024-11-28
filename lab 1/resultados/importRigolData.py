import RigolWFM.wfm as rigol
import pandas as pd

filename = './NewFile3.wfm'
scope = 'DS1102D'

scope_data = rigol.Wfm.from_file(filename, scope)

description = scope_data.describe()
print(description)

s = scope_data.csv()

rows = [row.split(',') for row in s.split('\n') if row.strip()]

# Dynamically generate column names based on the number of columns
num_columns = len(rows[0])  # Check the first row to determine the number of columns
column_names = [f"Column {i+1}" for i in range(num_columns)]  # e.g., Column 1, Column 2, ...

# Create a DataFrame
df = pd.DataFrame(rows, columns=column_names)

# Save to a CSV file
df.to_csv('output_file.csv', index=False)

