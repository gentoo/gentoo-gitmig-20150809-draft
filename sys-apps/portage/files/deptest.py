import readline
import portage
import sys
a=portage.portagetree("/usr/portage")
while (1):
	mydep=raw_input("dep> ")
	print a.depcheck(mydep)
