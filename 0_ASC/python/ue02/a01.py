import os
import urllib.request
import random
import gzip
import re

filePath = "./ftpSourceView.txt";

fileContent = open(filePath).readlines();

sourceUrl = fileContent[0].split()[1]
print("URL: " + sourceUrl)

unzippedFiles = []


for i in range(1000):
    data = {}
    fullUrl = sourceUrl + fileContent[2:][random.randint(0, len(fileContent) - 2)].split('"')[1] # faster than r"(\".*\")"
    content = gzip.GzipFile(fileobj=urllib.request.urlopen(fullUrl)).readlines()
    split = content[0].split()
    data["header"] = split[1]
    data["pdbid"] = split[3]
    for line in content[1:]:
        match = re.match(r"TITLE\s\d?\s?(.*)", line)
        if match != None:
            data["title"] = match.group(1)
        elif line.startswith("ATOM"):
            split = line.split();
            # TODO
        else:
            match = re.match(r".*CHAIN:\s(.*);", line)
            data["chain"] = match.group(1)
        print(data["title"])

