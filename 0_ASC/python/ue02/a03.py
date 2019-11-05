import re
import pprint

pp = pprint.PrettyPrinter(indent=2)

emailFile = open("./imgtSpeciesGeneInformation.txt", "r")

# pattern = re.compile(r"((\w*\s?)*);((\w*\d*-?)*);")

res_dict = {}
avail_gen = []
line_nr = 0

for i in emailFile.readlines()[1:]:
    mo = re.search(r"((\w*\s*)*);((\w|\d|-|/)*);.*", i)
    line_nr += 1
    if mo != None:
        if len(mo.group(3)) < 4:
            continue
        if mo.group(1) not in res_dict:
            res_dict[mo.group(1)] = {}
        if mo.group(3)[3] not in res_dict[mo.group(1)]:
            res_dict[mo.group(1)][mo.group(3)[3]] = 0
        res_dict[mo.group(1)][mo.group(3)[3]] += 1
        avail_gen.append(mo.group(3)[3])

print("done reading")

avail_gen = set(avail_gen)

for g in avail_gen:
    for k in res_dict:
        if g not in k:
            k[g] = 0

for k in res_dict:
    # TODO

pp.pprint(res_dict)

emailFile.close()


