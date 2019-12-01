input_string = ""
input_number = -1
max_number = 0
length = 0
while input_number != 0:
    input_string = input("Bitte Seriennummer eingeben: ")
    input_number = int(input_string)
    if input_number != 0:
        length = length + 1
        if input_number > max_number:
            max_number = input_number

print("Es gibt ca " + str(max_number + max_number / length - 1) + " Geräte.")
