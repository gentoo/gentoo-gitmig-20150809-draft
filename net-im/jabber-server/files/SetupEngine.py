#!/usr/bin/env python

#####################################################
##                                                 ##
## Written By Bart Verwilst <verwilst@gentoo.org>  ##
##                                                 ##
#####################################################

GeneralData = {}

## List all Attribs for GeneralData ##
GeneralData['domainname'] = ''
GeneralData['vcard_subject'] = ''
GeneralData['vcard_desc'] = ''
GeneralData['vcard_url'] = ''
GeneralData['admin_notif'] = ''
GeneralData['new_welcome'] = 0 ## 0 for no messages, 1 for messages ##
GeneralData['new_welcome_subject'] = ''
GeneralData['new_welcome_body'] = ''
GeneralData['vcard2jud'] = 0 ## 0 for no messages, 1 for messages ##
#GeneralData[''] = ''


def ShowIntro():
	print " "
	print " Choose one of the following options: "
	print "   [1] General Server Configuration "
        print "   [2] JUD Configuration "
        print "   [3] AIM Transport Configuration "
        print "   [4] ICQ Transport Configuration "
        print "   [5] MSN Transport Configuration "
	print "   [6] Write Configuration File "
	print "   [7] Quit "
	print " "

def SetupGeneral():
	print " "
	print "<---| General Server Configuration |--------------------------------->"
	GeneralData['domainname'] = raw_input("  Server DomainName (eg. myjabberserver.com):\n  # ")
	GeneralData['vcard_subject'] = raw_input("  Server vCard: Subject (eg. Jabber Server):\n  # ")
	GeneralData['vcard_desc'] = raw_input("  Server vCard: Description (eg. My Jabber Server!):\n  # ")
	GeneralData['vcard_url'] = raw_input("  Server vCard: WebSite URL (eg. http://foo.bar):\n  # ")
        a = raw_input("  Admin gets notified of new registration? ([yes]|no):\n  # ")
	if a == "no" or a == "n":
	        GeneralData['admin_notif'] = 0
        elif a == "yes" or a == "ye" or a == "y":
                GeneralData['admin_notif'] = 1
	else:
		print "   * Incorrect Input, Assuming \"Yes\" *"
                GeneralData['admin_notif'] = 1

	f = raw_input("  Send welcome Message to new users? (yes|[no]):\n  # ")
	if f == "yes" or f == "ye" or f == "y":
		GeneralData['new_welcome_subject'] = raw_input("    * Message Subject (eg. Welcome!):\n      # ")
		GeneralData['new_welcome_body'] = raw_input("    * Message Body (eg. Welcome to our Jabber server...):\n      # ")
	else:
		print "   * Welcome Messages will NOT be sent *"

        b = raw_input("  Auto-Update JUD when vCard is edited? ([yes]|no):\n  # ")
	if b == "no" or b == "n":
                GeneralData['vcard2jud'] = 0
        elif b == "yes" or b == "ye" or b == "y":
                GeneralData['vcard2jud'] = 1
	else:
		print "   * Incorrect Input, Assuming \"Yes\" *"
                GeneralData['vcard2jud'] = 1


	print " "
	print " *** General Server Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def JUDConfig():
        pass
def AIMConfig():
        pass
def ICQConfig():
        pass
def MSNConfig():
        pass
def WriteConfig():
	pass
