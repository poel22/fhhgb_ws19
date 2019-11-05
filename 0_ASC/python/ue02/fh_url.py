import os
import urllib.request
import re

url = "http://imgt.org/IMGTrepertoire/index.php?section=LocusGenes&repertoire=genetable&species=human&group="

urlList = [ 'IGHV', 'IGHD', 'IGHJ' ]

def writeTxtFile(dlList, codex):
    path = r"./genes"
    if not os.path.exists(path) : os.makedirs(path)

    f = open(path + "/" + str(codex) + ".txt", "w")
    for i in dlList:
        f.writelines(i + "\n")
    f.close()

def loadAntibodyFiles (urlList):

    for i in urlList:
        fileH = urllib.request.urlopen(url + i)

        listOfGenes = []
        listOfAlleles = []

        for j in fileH.readlines():
            # print(j)
            moGene = re.search(r"<.*class=\"gene_note\".*><.*>(.*)</.*></.*>", str(j))
            moAllele = re.search(r"<.*class=\"allele_note\".*><.*>(.*)</.*></.*>", str(j))
            if moGene != None:
                listOfGenes.append(moGene.group(1))
            if moAllele != None:
                listOfGenes.append(moAllele.group(1))
        writeTxtFile(listOfGenes, i);
        writeTxtFile(listOfAlleles, i + "Allele")

loadAntibodyFiles(urlList)
