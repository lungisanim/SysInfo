#This python script should run after the information.bat script has run to prevent a : FileNotFoundError: [Errno 2] No such file or directory: error
import os

endline = os.linesep

filename = 'information.txt'

#The information.txt contained in the data object
with open(filename) as theFile:
	data = theFile.readlines()

#I have the information, now should just take the useful chunks into paragraphs to be used for the final report : before geting the lengths 	
	
	#Use-cases: They are wrong
	#line1 filesystem type
	#line6-38 = CHKDSK is verifying files
	#line39-544 = CHKDSK is verifying indexes
	#line546-566 = CHKDSK is verifying security descriptors
	#line568-573 = CHKDSK is verifying Usn Journal
	#line574 = Windows has checked the file system and found no problems.
	#line576-586 = Spacedetails
	#line587-615 = Server Statistics
	#line617-644 = Workstation Statistics
	#line646-662 = Workstation Configuration
	#line665-791 = Tasklist
	
	#might have to create separate files for each command, painfully but may be necessary | alternative is to search through the file(seems more professional that way)
	
#Object size
length = len(data)
list = []
print(length)
for i in range(2, 5):
	list.append(str(data[i]))
	print(list)
	
#for i in range(0, length):
#	print(data[i])
#echo 'hello'	
print(type)
#for i in range(len(data.readlines())):
#	print ('hello world')

#I will have to do the commands separately, do the job, finish the job. Then modify the job

#1.start extraction 2.start pdfgen 3.now use reportlab to beautify the information 4.start email 5.Installer to remote workstations
#Still need the files that have the most data, to be displayed seperately
#Done now to make the file with sizes more visually appealing, reportlab