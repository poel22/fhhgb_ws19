import re

emailFile = open("Inputdaten/eMailFile.txt", "r")

# pattern = re.compile(r"(\w|-)*(\.\w*)*@(\w|-)*(\.\w*)+")

for i in emailFile.readlines():
    # mo = pattern.findall(i)
    mo = re.search(r"(\w|-)*(\.\w*)*@(\w|-)*(\.\w*)+", i)
    if mo != None:
        print(mo)
    else:
        print("No match found!")


emailFile.close()

####

ref = open("./Inputdaten/reference.txt", "r")


for i in ref.readlines():
    mo = re.search(r"(\w+)\s*([A-Za-z]*)\s*(555-[0-9]{4})", i)
    if mo != None:
        print(mo)
        lastName = mo.group(1)
        firstName = mo.group(2)
        phoneNr = mo.group(3)
        if (phoneNumber != ""):
            print(phoneNumber + "," + lastName + ", " + firstName)

