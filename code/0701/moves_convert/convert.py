import os
import csv
import json

jsonFileName = 'storyline.geojson'
exportDir = 'csv/'

# Functions
def convertTimeStr( str ):
   return str[:4] + '-' + str[4:6] + '-' + str[6:11]  + ':' + str[11:13] + ':' + str[13:15] + str[15:18] + ':' + str[18:20]

# create processing/ folder if not exist
if not os.path.exists(exportDir):
	os.makedirs(exportDir)

# coverts json to csv
with open(jsonFileName) as jsonFile, open(exportDir + 'storyline.csv', 'wb') as csvOutput:
	csvWriter = csv.DictWriter(csvOutput, ['Date','Type','Name','Start','End','Duration','File'])
	csvWriter.writeheader()
	jsonData = json.load(jsonFile)
	features = jsonData['features']
	for feature in features:
		properties = feature['properties']
		featureType = properties['type']
		featureDate = properties['date']
		featureDate = featureDate[:4] + '/' + featureDate[4:6] + '/' + featureDate[6:8]
		if 'place' in properties:
			featureName = 'place'
			if 'name' in properties['place']:
				featureName = properties['place']['name']
			startTime = convertTimeStr(properties['startTime'])
			endTime = convertTimeStr(properties['endTime'])
			duration = 0
			csvWriter.writerow(dict(Date=featureDate, Type=featureType, Name=featureName, Start=startTime, End=endTime, Duration=duration, File=''))
		else:
			for index, activity in enumerate(properties['activities']):
				featureName = activity['activity']
				startTime = convertTimeStr(activity['startTime'])
				endTime = convertTimeStr(activity['endTime'])
				duration = activity['duration']
				distance = activity['distance']
				fileName = activity['startTime'][:15] + '.csv'
				csvWriter.writerow(dict(Date=featureDate, Type=featureType, Name=featureName, Start=startTime, End=endTime, Duration=duration, File=fileName))
				with open(exportDir+fileName, 'wb') as routeCSV:
					routeCSVWriter = csv.DictWriter(routeCSV, ['latitude', 'longitude'])
					routeCSVWriter.writeheader()
					coordinates = feature['geometry']['coordinates'][index]
					for coordinate in coordinates:
						routeCSVWriter.writerow(dict(latitude=coordinate[1], longitude=coordinate[0]))

print "Successfully Converted!"
