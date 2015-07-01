from bs4 import BeautifulSoup
import seaborn
import requests
import pandas as pd
url ='https://www.kaggle.com/competitions/search?SearchVisibility=AllCompetitions&ShowCompleted=true&ShowProspect=true&ShowOpenToAll=true&ShowPrivate=true&ShowLimited=true&DeadlineColumnSort=Ascending'
r = requests.get(url)
b = BeautifulSoup(r.content)
table = b.find('table')
headings = [th.get_text() for th in table.find("tr").find_all("th")]
headings = [s.strip() for s in headings]
datasets = []
for row in table.find_all("tr")[1:]:
        datasets.append( [td.get_text() for td in row.find_all('td')])
df = pd.DataFrame.from_records(datasets)
df.columns = headings
df.head()
df['Competition'] = df['Competition Name'].str.strip()
df.Teams = df.Teams.astype('int')
df[['Teams', 'Reward']].plot()
