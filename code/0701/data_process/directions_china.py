# GAODE MAP
# http://lbs.amap.com/api/webservice/reference/direction/
# Test Code
# curl -o route.json 'http://restapi.amap.com/v3/direction/walking?origin=121.53415,31.225854&destination=121.531689,31.222631&output=json&key=a291ad0a190edffc337e949f64e28285'
# 
# NEED TO CONVERT 
# from gcj2 to wgs84, https://en.wikipedia.org/wiki/Restrictions_on_geographic_data_in_China
#
# CONFIGURE
# 
# Access Token
# login and go to page: http://lbs.amap.com/console/key/
# create Web Service API
access_token = "a291ad0a190edffc337e949f64e28285"
direction_mode = "walking" # driving or transit


import os
import csv
import json
import subprocess
import eviltransform	#https://github.com/googollee/eviltransform

jsonDir = 'json/'
# create json/ folder if not exist
if not os.path.exists(jsonDir):
	os.makedirs(jsonDir)

inputFileName = "places_shanghai.csv"
exportDir = 'shanghai/'
# create processing/ folder if not exist
if not os.path.exists(exportDir):
	os.makedirs(exportDir)

# load places csv file and download directions
with open(inputFileName) as csvInput, open(exportDir + inputFileName, 'wb') as csvOutput:
	csvReader = csv.DictReader(csvInput)
	fieldnames = csvReader.fieldnames + ['filename', 'duration', 'distance']
	csvWriter = csv.DictWriter(csvOutput, fieldnames)
	csvWriter.writeheader()
	for index, row in enumerate(csvReader):
		# set up json output file
		jsonFileName = jsonDir + 'file_%s.json' % index
		startPlace = row['startLng'] + "," + row['startLat']
		endPlace = row['endLng'] + "," + row['endLat']
		# print row['startLat'], row['startLng'], row['endLat'], row['endLng']
		startLatLng = eviltransform.gcj2wgs(float(row['startLat']), float(row['startLng']))
		endLatLng = eviltransform.gcj2wgs(float(row['endLat']), float(row['endLng']))
		subprocess.Popen("curl -o " + jsonFileName + " 'http://restapi.amap.com/v3/direction/" + direction_mode + "?origin=" + startPlace + "&destination=" + endPlace + "&output=json&key=" + access_token + "'", shell=True, stdout=subprocess.PIPE).stdout.read()
		
		# coverts json to csv
		with open(jsonFileName) as jsonFile:
			jsonData = json.load(jsonFile)
			jsonRoute = jsonData['route']['paths'][0]
			duration = jsonRoute['duration']
			distance = jsonRoute['distance']
			steps = jsonRoute['steps']

			# create a new csv for processing
			csvFileName = 'file_%s.csv' % index
			with open(exportDir+csvFileName, 'wb') as processinCSV:
				processingCSVWriter = csv.DictWriter(processinCSV, ['latitude', 'longitude'])
				processingCSVWriter.writeheader()
				prevLat = 0
				prevLng = 0
				for step in steps:
					polyline = step['polyline']
					pairs = polyline.split(";")
					for pair in pairs:
						lnglat = pair.split(",")
						if( float(lnglat[1]) == prevLat and float(lnglat[0]) == prevLng ):
							continue
						oneLatLng = eviltransform.gcj2wgs(float(lnglat[1]), float(lnglat[0]))
						processingCSVWriter.writerow(dict(latitude=oneLatLng[0], longitude=oneLatLng[1]))
						prevLat = float(lnglat[1])
						prevLng = float(lnglat[0])

		# add a row in the output file
		csvWriter.writerow(dict(startLat=startLatLng[0], startLng=startLatLng[1], endLat=endLatLng[0], endLng=endLatLng[1], filename=csvFileName, duration=duration, distance=distance))

	print "Successfully Downloaded Directions"
