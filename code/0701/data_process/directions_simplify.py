# Mapbox Direction API
# https://www.mapbox.com/developers/api/directions/
# Test Code
# curl -o route.json 'https://api.mapbox.com/v4/directions/mapbox.driving/-122.42,37.78;-77.03,38.91.json?access_token=pk.eyJ1IjoieHlmZW5nIiwiYSI6IjRZNzdCbEkifQ.y54-xYgxPAeDY0VYy9qEGw'

# CONFIGURE
# 
# Access Token
# login and go to page: https://www.mapbox.com/studio/
access_token = "pk.eyJ1IjoieHlmZW5nIiwiYSI6IjRZNzdCbEkifQ.y54-xYgxPAeDY0VYy9qEGw"
direction_mode = "mapbox.walking" # mapbox.driving or mapbox.cycling
evilTrans = True  # from gcj2 to wgs84, https://en.wikipedia.org/wiki/Restrictions_on_geographic_data_in_China


import os
import csv
import json
import subprocess
import eviltransform	#https://github.com/googollee/eviltransform

jsonDir = 'json/'
# create json/ folder if not exist
if not os.path.exists(jsonDir):
	os.makedirs(jsonDir)

processingDir = 'processing/'
# create processing/ folder if not exist
if not os.path.exists(processingDir):
	os.makedirs(processingDir)

# create processing/ folder if not exist

# load places csv file and download directions
with open('places.csv') as csvInput, open('processing/places.csv', 'wb') as csvOutput:
	csvReader = csv.DictReader(csvInput)
	fieldnames = csvReader.fieldnames + ['filename', 'duration', 'distance']
	csvWriter = csv.DictWriter(csvOutput, fieldnames)
	csvWriter.writeheader()
	for index, row in enumerate(csvReader):
		# set up json output file
		jsonFileName = jsonDir + 'file_%s.json' % index
		# print row['startLat'], row['startLng'], row['endLat'], row['endLng']
		if evilTrans:
			startLatLng = eviltransform.gcj2wgs(float(row['startLat']), float(row['startLng']))
			startPlace = str(startLatLng[1]) + "," + str(startLatLng[0])
		else:
			startPlace = row['startLng'] + "," + row['startLat']
		if evilTrans:
			endLatLng = eviltransform.gcj2wgs(float(row['endLat']), float(row['endLng']))
			endPlace = str(endLatLng[1]) + "," + str(endLatLng[0])
		else:
			endPlace = row['endLng'] + "," + row['endLat']
		subprocess.Popen("curl -o " + jsonFileName + " 'https://api.mapbox.com/v4/directions/" + direction_mode + "/" + startPlace + ";" + endPlace + ".json?alternatives=false&steps=false&access_token=" + access_token + "'", shell=True, stdout=subprocess.PIPE).stdout.read()
		
		# coverts json to csv
		with open(jsonFileName) as jsonFile:
			jsonData = json.load(jsonFile)
			jsonRoute = jsonData['routes'][0]
			duration = jsonRoute['duration']
			distance = jsonRoute['distance']
			coordinates = jsonRoute['geometry']['coordinates']

			# create a new csv for processing
			csvFileName = 'file_%s.csv' % index
			with open(processingDir+csvFileName, 'wb') as processinCSV:
				processingCSVWriter = csv.DictWriter(processinCSV, ['latitude', 'longitude'])
				processingCSVWriter.writeheader()
				for pair in coordinates:
					processingCSVWriter.writerow(dict(latitude=pair[1], longitude=pair[0]))

		# add a row in the output file
		if evilTrans:
			csvWriter.writerow(dict(startLat=startLatLng[0], startLng=startLatLng[1], endLat=endLatLng[0], endLng=endLatLng[1], filename=csvFileName, duration=duration, distance=distance))
		else:
			csvWriter.writerow(dict(row, filename=csvFileName, duration=duration, distance=distance))

	print "Successfully Downloaded Directions"
