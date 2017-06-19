from bs4 import BeautifulSoup
import requests
import pandas as pd
url ='https://www.kaggle.com/competitions/search?SearchVisibility=AllCompetitions&ShowCompleted=true&ShowProspect=true&ShowOpenToAll=true&ShowPrivate=true&ShowLimited=true&DeadlineColumnSort=Ascending'
url2 = 'https://www.kaggle.com/competitions/search?SearchVisibility=AllCompetitions&ShowActive=true&ShowCompleted=true&ShowProspect=true&ShowOpenToAll=true&ShowPrivate=true&ShowLimited=true&DeadlineColumnSort=Ascending'
url3 = 'https://www.kaggle.com/c/diabetic-retinopathy-detection/leaderboard'
r = requests.get(url3)
b = BeautifulSoup(r.content)
table = b.find('table')
headings = [th.get_text() for th in table.find("tr").find_all("th")]
headings = [s.strip() for s in headings]
datasets = []
for row in table.find_all("tr")[1:]:
        datasets.append( [td.get_text() for td in row.find_all('td')])
df = pd.DataFrame.from_records(datasets)
df.columns = headings
#df['Competition'] = df['Competition Name'].str.strip().str.replace('\W+', ' ')
#df.Teams = df.Teams.astype('int')
#reward = df.Reward
#reward = reward.str.replace('[,\$]', '')
#reward = reward.str.replace('Knowledge|Kudos|Jobs|Swag|Private', '0')
#df['Reward_amount'] = reward
#df.to_csv('kaggle_comp2.csv', encoding='utf-8')
