import re

result_dict = {}

line_number = 0

for line in open("./code.txt", "r"):
    for word in re.sub('\W', ' ', line).split():
        if len(word) < 2:
            continue
        if word not in result_dict:
            result_dict[word] = []
        result_dict[word].append(line_number)
    line_number = line_number + 1

print(result_dict)
