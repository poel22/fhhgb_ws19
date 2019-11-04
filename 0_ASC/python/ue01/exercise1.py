import os
import re
import pprint

genome_parts = ['A', 'C', 'G', 'T']
sequences = []
sequence = []
for line in open("./ecoli.txt", "r"):
    line = line.replace('\n', '')
    if re.match('>.*', line) != None:
        sequences.append(''.join(sequence))
        sequence = []
    elif line != '' and line != '\n':
        sequence.append(line)

sequences.append(''.join(sequence))

del sequences[0]

stat_all = {}
stat_single_list = []
length_all = 0

for g in genome_parts:
    stat_all[g] = 0

for s in sequences:
    stat_sum = 0
    stat_single = {}
    for g in genome_parts:
        length = len(re.findall(g, s))
        stat_all[g] = stat_all[g] + length
        stat_single[g] = length
        stat_sum = stat_sum + length
    stat_single['sum'] = stat_sum
    stat_single_list.append(stat_single)

overall_sum = 0

for stat in stat_single_list:
    overall_sum = overall_sum + stat['sum']
    for g in genome_parts:
        stat[g] = stat[g] / stat['sum']

for g in genome_parts:
    stat_all[g] = stat_all[g] / overall_sum

print("all:")
print(stat_all)
print("single:")
print(stat_single_list)
