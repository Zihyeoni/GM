import pandas as pd

trimmed_df = pd.read_csv("trimmed_DB_7.csv")
kit_open_df = pd.read_csv("Kit-Open.csv")
kit_click_df = pd.read_csv("Kit-Click.csv")

merge_kit_open_df = pd.merge(kit_open_df, trimmed_df, how="left", on="email")
merge_kit_click_df = pd.merge(kit_click_df, trimmed_df, how="left", on="email")

unique_merge_kit_open_df = merge_kit_open_df.drop_duplicates(subset=['first_name', 'email'],  keep='last')
unique_merge_kit_click_df = merge_kit_click_df.drop_duplicates(subset=['first_name', 'email'], keep='last')

unique_merge_kit_open_df.to_csv("merge_kit_open_df.csv")
unique_merge_kit_click_df.to_csv("merge_kit_click_df.csv")