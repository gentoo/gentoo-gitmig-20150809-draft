#!/usr/bin/env python

##################################################################
##                                                              ##
## Written By Bart Verwilst <verwilst@gentoo.org>               ##
## For additions and bugfixes, Please consult the author!       ##
##                                                              ##
##################################################################

global GeneralData
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

global JUDData
JUDData = {}

## List all Attribs for JUDData ##
JUDData['extra_jud'] = 0
JUDData['jid'] = ''
JUDData['name'] = ''

global CONData
CONData = {}

## List all Attribs for CONData ##
CONData['enable_con'] = 0
CONData['jid'] = ''
CONData['name'] = ''

global AIMData
AIMData = {}

## List all Attribs for AIMData ##
AIMData['enable_aim'] = 0
AIMData['jid'] = ''
AIMData['name'] = ''

global ICQData
ICQData = {}

## List all Attribs for ICQData ##
ICQData['enable_icq'] = 0
ICQData['jid'] = ''
ICQData['name'] = ''

global MSNData
MSNData = {}

## List all Attribs for MSNData ##
MSNData['enable_msn'] = 0
MSNData['jid'] = ''
MSNData['name'] = ''

global YahooData
YahooData = {}

## List all Attribs for MSNData ##
YahooData['enable_yahoo'] = 0
YahooData['jid'] = ''
YahooData['name'] = ''


def ShowIntro():
	print " "
	print " Choose one of the following options: "
	print "   [1] General Server Configuration "
        print "   [2] JUD Configuration "
        print "   [3] Conference Configuration "
        print "   [4] AIM Transport Configuration "
        print "   [5] ICQ Transport Configuration "
        print "   [6] MSN Transport Configuration "
        print "   [7] Yahoo! Transport Configuration "
        print "   [8] Server Security Configuration "
	print "   [9] Write Configuration File "
	print "   [0] Quit "
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

	b = raw_input("  Send welcome Message to new users? (yes|[no]):\n  # ")
	if b == "yes" or b == "ye" or b == "y":
                GeneralData['new_welcome'] = 1
		GeneralData['new_welcome_subject'] = raw_input("    * Message Subject (eg. Welcome!):\n      # ")
		GeneralData['new_welcome_body'] = raw_input("    * Message Body (eg. Welcome to our Jabber server...):\n      # ")
	else:
                GeneralData['new_welcome'] = 0
		print "   * Welcome Messages will NOT be sent *"

        c = raw_input("  Auto-Update JUD when vCard is edited? ([yes]|no):\n  # ")
	if c == "no" or c == "n":
                GeneralData['vcard2jud'] = 0
        elif c == "yes" or c == "ye" or c == "y":
                GeneralData['vcard2jud'] = 1
	else:
		print "   * Incorrect Input, Assuming \"Yes\" *"
                GeneralData['vcard2jud'] = 1


	print " "
	print " *** General Server Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()


def JUDConfig():
        print " "
	print "<---| Jabber User Directory Configuration |--------------------------------->"

        a = raw_input(" Do you want to add a second JUD (eg. Intranet JUD?) ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                JUDData['extra_jud'] = 1
                JUDData['jid'] = raw_input("    Enter JabberID for server (eg. users.foo.bar):\n      # ")
                JUDData['name'] = raw_input("    Enter Name for server (eg. My Intranet JUD):\n      # ")
	else:
		print "   * No extra JUD will be configured *"
                JUDData['extra_jud'] = 0

        print " "
	print " *** JUD Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def CONConfig():
        print " "
	print "<---| Conference Configuration |--------------------------------->"
        a = raw_input(" Do you want to enable Conferencing on your server? ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                CONData['enable_con'] = 1
                CONData['jid'] = raw_input("    Enter Prefix for the Conference Host (default: conference):\n      # ")
                CONData['name'] = raw_input("    Enter Name for Conference Transport (eg. My Own Conf. Transport):\n      # ")
	else:
		print "   * No extra JUD will be configured *"
                CONData['extra_jud'] = 0

        print " "
	print " *** Conference Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def AIMConfig():
        print " "
	print "<---| AIM Transport Configuration |--------------------------------->"
        a = raw_input(" Do you want to enable the AIM Transport on your server? ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                AIMData['enable_aim'] = 1
                AIMData['jid'] = raw_input("    Enter Prefix for the AIM Host (default: aim):\n      # ")
                AIMData['name'] = raw_input("    Enter Name for AIM Transport (eg. My Own AIM Transport):\n      # ")
	else:
		print "   * AIM Transport will NOT be installed *"
                AIMData['enable_aim'] = 0

        print " "
	print " *** AIM Transport Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def ICQConfig():
        print " "
	print "<---| ICQ Transport Configuration |--------------------------------->"
        a = raw_input(" Do you want to enable the ICQ Transport on your server? ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                ICQData['enable_icq'] = 1
                ICQData['jid'] = raw_input("    Enter Prefix for the ICQ Host (default: icq):\n      # ")
                ICQData['name'] = raw_input("    Enter Name for ICQ Transport (eg. My Own ICQ Transport):\n      # ")
	else:
		print "   * ICQ Transport will NOT be installed *"
                ICQData['enable_icq'] = 0

        print " "
	print " *** ICQ Transport Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def MSNConfig():
        print " "
	print "<---| MSN Transport Configuration |--------------------------------->"
        a = raw_input(" Do you want to enable the MSN Transport on your server? ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                MSNData['enable_msn'] = 1
                MSNData['jid'] = raw_input("    Enter Prefix for the MSN Host (default: msn):\n      # ")
                MSNData['name'] = raw_input("    Enter Name for MSN Transport (eg. My Own MSN Transport):\n      # ")
	else:
		print "   * MSN Transport will NOT be installed *"
                MSNData['enable_msn'] = 0

        print " "
	print " *** MSN Transport Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def YahooConfig():
        print " "
	print "<---| Yahoo! Transport Configuration |--------------------------------->"
        a = raw_input(" Do you want to enable the Yahoo! Transport on your server? ([yes]|no):\n  # ")
        if a == "yes" or a == "ye" or a == "y" or a == "":
                YahooData['enable_yahoo'] = 1
                YahooData['jid'] = raw_input("    Enter Prefix for the Yahoo! Host (default: msn):\n      # ")
                YahooData['name'] = raw_input("    Enter Name for Yahoo! Transport (eg. My Own Yahoo! Transport):\n      # ")
	else:
		print "   * Yahoo! Transport will NOT be installed *"
                MSNData['enable_yahoo'] = 0

        print " "
	print " *** Yahoo! Transport Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()

def SecurityConfig():
        print " "
	print "<---| Server Security Configuration |--------------------------------->"

        print " "
	print " *** Server Security Configuration Finished SuccessFully! ***"
	print " "
	ShowIntro()