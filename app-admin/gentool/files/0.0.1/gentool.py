#!/usr/bin/python
#
# Gentool.  Written by warren.  Released under GNU.
#
#
# NOTE: this should be ran as root... but then again.. that's probably a security hazard... :)
#
#
#
# Change Log
# ----------
#
#	0.0.1
#		fixed a problem with viewing details of a package that isn't already installed
#		added run-command for rsync
#	0.0.0
#		initial release
#
#
# To-Do
# -----
#
#	-set up some sort of buffering system so popen (as well as everything else) doesn't tie up
#		up other connections.  (have it fork perhaps? not sure...).  (but then again... there
#		should never really be more than one person on it... oh well still a bug)
#	-try to hack it (buffer overflows? etc...) and fix it if anything is vulnerable.. :)
#	-add an idiot-proof section so you can modify the USE variables easily.
#

server_version = "Gentool 0.0.1 (Gentoo)"	# don't change this

port = 8088										# port this runs on (i.e. http://localhost:port/)
username = "gentoo"									# username 
password = "gentoo"									# password
install_command = "/usr/sbin/emerge --pretend"		# change to "/usr/sbin/emerge" if you want it to actually merge packages
uninstall_command = "/bin/echo removing:"			# change to "/usr/sbin/ebuild" if you want it to actually unmerge packages
rsync_command = "/usr/sbin/emerge rsync"			# command to rsync
path_to_graphics = "/usr/share/gentool/images/"	# change to the path of gentoo.gif



#
# nothing below here should be changed...
#

import os
import sys
import socket
import select
import string
import base64
import portage
import urllib


class session:
	raw_data = ""									# raw data before it gets parsed
	all_headers = []								# each line of the header
	form_data = ""									# data from FORM post and/or in the URL
	method = ""										# usually GET or POST
	version = ""									# usually HTTP/1.1
	uri = ""										# the document the user wants minus any ?blah=blah&blah=blah stuff

	authorized = 0
	def CheckSocketForData(self):
		# returns 0 if everything is okay, and 1 if the socket has been dropped

		# get all headers and possible post data (can't get headers/body bigger than a meg...)
		# hrmm... if the browser doesn't send all the data at once... this won't read all of the
		#    data... TODO: make it loop until it gets <ENTER><ENTER> and then continue with sending
		#    to different functions
		self.raw_data = self.socket.recv(1048576)
		if len(self.raw_data) != 0:
			self.ParseClientData()
			self.SendOutput()
		self.socket.close()
		return 1

	def ParseClientData(self):
		# NOTE: assumes linefeeds == "\r\n"... might not be true for all browsers?
		print "Parsing headers..."

		splitting_point = string.find(self.raw_data,"\r\n\r\n")
		header_part = self.raw_data[0:splitting_point]
		body_part = self.raw_data[splitting_point+4:]

		request = string.split(header_part,"\r\n")[0]
		if len(string.split(request)) != 3:
			print "Invalid request"
			return 1

		self.method = string.split(request)[0]  # for instance, GET or POST
		print "   Method: ", self.method
		self.version = string.split(request)[2] # for instance, HTTP/1.1
		print "   Version: ", self.version

		temp_uri = string.split(string.split(request)[1],"?")
		if len(temp_uri) == 2:
			self.uri = temp_uri[0]
			self.form_data = temp_uri[1]
		else:
			self.uri = temp_uri[0]

		print "   URL: ", self.uri
		print "   Headers:"

		num_lines = 1
		for line in string.split(header_part,"\r\n")[1:]:
			self.all_headers[num_lines:num_lines] = [line] 
			num_lines = num_lines + 1
			print "     ", line
			if len(line) == 0:
				break

		print "Storing data..."
		if body_part != "":
			if self.form_data!= "":
				# ?something=something in the URI (hrmm... posting and a ?something=something in the url? odd...)	
				self.form_data = self.form_data + "&" + body_part
			else:
				self.form_data = body_part

		print "Checking authorization... ",
		for x in self.all_headers:
			line = string.split(x)
			if len(line) == 3:
				if string.lower(line[0]) == "authorization:":
					base64_string = line[2]
					decoded_string = base64.decodestring(base64_string)
					entered_username = string.split(decoded_string,":")[0]
					entered_password = string.split(decoded_string,":")[1]
					if entered_username == username:
						if entered_password == password:
							self.authorized = 1
							break	#does this break out of the for or one of the if's?
						else:
							break	#does this break out of the for or one of the if's?
					else:
						break	#does this break out of the for or one of the if's?
		if self.authorized == 0:
			print "failed"
		else:
			print "passed"


	def SendOutput(self):

		if self.authorized:
			#####################################################################################################
			#####################################################################################################
			##
			## Index page
			##
			if self.uri == "/":
				self.PrintHeader()
				self.PrintHTMLHeader("Pick which packages you want to upgrade...")
				self.socket.send("""<CENTER>Welcome to gentoo linux!</CENTER><BR><BR>(This page will have more in the future).""")
				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Print out packages that can be updated
			##
			elif self.uri == "/view-upgrades":

				self.PrintHeader()
				self.PrintHTMLHeader("Pick which packages you want to upgrade...")

				myvirtuals=portage.getvirtuals(portage.root)

				allpackages = portage.portagetree("/",myvirtuals)
				allpackages.populate()

				mypackages = portage.vartree("/",myvirtuals)
				mypackages.populate()

				self.socket.send("""
						The following packages should be upgraded:<BR><BR>

						<FORM METHOD="post" ACTION="/upgrade-packages">
						<TABLE WIDTH="70%" CELLSPACING=1 CELLPADDING=0 BORDER=0 ALIGN="center" BGCOLOR="#000000"><TR><TD>
						<TABLE WIDTH="100%" CELLSPACING=0 CELLPADDING=3 BORDER=0>
						<TR>
							<TD WIDTH="45%" BGCOLOR="#202020"><FONT COLOR="#ffffff"><B>Package Name</FONT></TD>
							<TD WIDTH="25%" ALIGN="center" BGCOLOR="#202020"><FONT COLOR="#ffffff"><B>Current Version</FONT></TD>
							<TD WIDTH="25%" ALIGN="center" BGCOLOR="#202020"><FONT COLOR="#ffffff"><B>Latest Version</B></FONT></TD>
							<TD WIDTH="5%" ALIGN="center" BGCOLOR="#202020"><FONT COLOR="#ffffff"><B>Upgrade</B></FONT></TD>
						</TR>""")
				switch = 0
				for x in mypackages.tree.keys():
					should_we_upgrade = 0  # 0 == don't know, 1 == yes, 2 == no
					temp_package = mypackages.tree[x][0][1][0] + "/" + mypackages.tree[x][0][1][1]
					temp_best_match = allpackages.dep_bestmatch(temp_package)
					latest_package = portage.catpkgsplit(temp_best_match)[1:]
					for y in mypackages.tree[x]:
						current_package = portage.catpkgsplit(y[0])[1:]
						compare_value = portage.pkgcmp(current_package,latest_package)
						if compare_value == -1:
							if should_we_upgrade != 2:
								should_we_upgrade = 1
						else:
							should_we_upgrade = 2
					if should_we_upgrade == 1:
						if switch == 0:
							switch = 1
							color = "#cccccc"
						else:
							switch = 0
							color = "#bbbbbb"

						latest_ebuild_name = allpackages.getname(mypackages.tree[x][0][1][0] + "/" + latest_package[0] + "-" + latest_package[1] + "-" + latest_package[2])

						ebuild_names = latest_ebuild_name + "|"
						first_one = 1
						for y in mypackages.tree[x]:
							if first_one == 1:
								ebuild_names = ebuild_names + allpackages.getname(y[0])
								first_one = 0
							else:
								ebuild_names = "|" + ebuild_names + allpackages.getname(y[0])

						self.socket.send("""
							<TR>
								<TD BGCOLOR=""" + "\"" + color + "\">" + latest_package[0] + """</TD>
								<TD ALIGN="center" BGCOLOR=""" + "\"" + color + "\">" + current_package[1] + "-" + current_package[2] + """</TD>
								<TD ALIGN="center" BGCOLOR=""" + "\"" + color + "\">" + latest_package[1] + "-" + latest_package[2] + """</TD>
								<TD ALIGN="center" BGCOLOR=""" + "\"" + color + "\"" + """>
									<INPUT TYPE="checkbox" NAME="package" VALUE=""" + "\"" + ebuild_names + "\"" + """>
								</TD>
							</TR>""")
				if switch == 0:
					switch = 1
					color = "#cccccc"
				else:
					switch = 0
					color = "#bbbbbb"
				self.socket.send("""
			<TR>
				<TD ALIGN="center" COLSPAN=4 BGCOLOR=""" + "\"" + color + "\"" + """>
					<INPUT TYPE="submit" VALUE="Upgrade Packages Now">
				</TD>
			</TR>
			</TABLE>
			</TD></TR></TABLE>
			</FORM>
		""")

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Print out all packages that have already been installed
			##
			elif self.uri == "/view-installed":

				self.PrintHeader()
				self.PrintHTMLHeader("Packages that are already installed...")
				myvirtuals=portage.getvirtuals(portage.root)

				mypackages = portage.vartree("/",myvirtuals)
				mypackages.populate()

				sorted_keys = mypackages.tree.keys()
				sorted_keys.sort()

				for c in portage.categories:
					# each category
					printed_category = 0
					for x in sorted_keys:
						# each package
						if mypackages.tree[x][0][1][0] == c:
							if printed_category == 0:
								self.socket.send("<B>" + c + "</B><BR>")
								printed_category = 1

							self.socket.send("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF=\"/package-details?package=" + mypackages.tree[x][0][1][0] + "/" + mypackages.tree[x][0][1][1] + "\">" + mypackages.tree[x][0][1][1] + "</A> (")
							printed_first = 0
							for y in mypackages.tree[x]:
								# each version of it
								if printed_first == 0:
									printed_first = 1
								else:
									self.socket.send(", ")
								self.socket.send(y[1][2] + "-" + y[1][3])
							self.socket.send(")<BR>")

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## package details
			##
			elif self.uri == "/package-details":
				self.PrintHeader()
				self.PrintHTMLHeader("Package details...")

				package_name = string.split(self.form_data,"=")[1]

				myvirtuals = portage.getvirtuals(portage.root)

				mypackages = portage.vartree("/",myvirtuals)
				mypackages.populate()

				allpackages = portage.portagetree("/",myvirtuals)
				allpackages.populate()


				self.socket.send("<CENTER><H1>" + package_name + "</H1></CENTER><BR>")
				self.socket.send("<BR><B>You have the following version(s) installed:</B><BR>")
				if package_name in mypackages.tree.keys():
					for x in mypackages.tree[package_name]:
						self.socket.send("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + x[0] + " <SMALL>[ <A HREF=\"remove-package?package=" + allpackages.getname(x[0]) + "\">remove</A> ]</SMALL><BR>")


				self.socket.send("<BR><B>You can install the following version(s):</B><BR>")
				for x in allpackages.tree[package_name]:
					if package_name in mypackages.tree.keys() and x in mypackages.tree[package_name]:
						#already installed
						pass
					else:
						self.socket.send("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + x[0] + " <SMALL>[ <A HREF=\"install-package?package=" + allpackages.getname(x[0]) + "\">install</A> ]</SMALL><BR>")

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## run emerge rsync
			##
			elif self.uri == "/rsync":

				self.PrintHeader()
				self.PrintHTMLHeader("Synchronizing... Please wait...")
				rsync_log = os.popen4(rsync_command)[1]

				while 1:
					c = rsync_log.readline()
					if c == "":
						break
					self.socket.send(c + "<BR>")



				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Print out all packages that can be installed
			##
			elif self.uri == "/view-available":

				self.PrintHeader()
				self.PrintHTMLHeader("Packages Available to Install...")

				myvirtuals=portage.getvirtuals(portage.root)

				allpackages = portage.portagetree("/",myvirtuals)
		                allpackages.populate()

				sorted_keys = allpackages.tree.keys()
				sorted_keys.sort()

				for c in portage.categories:
					# each category
					self.socket.send("<B>" + c + "</B><BR>")
					for x in sorted_keys:
						# each package
						if allpackages.tree[x][0][1][0] == c:
							self.socket.send("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF=\"/package-details?package=" + allpackages.tree[x][0][1][0] + "/" + allpackages.tree[x][0][1][1] + "\">" + allpackages.tree[x][0][1][1] + "</A> (")
							printed_first = 0
							for y in allpackages.tree[x]:
								# each version of it
								if printed_first == 0:
									printed_first = 1
								else:
									self.socket.send(", ")
								self.socket.send(y[1][2] + "-" + y[1][3])
							self.socket.send(")<BR>")


				self.PrintHTMLFooter()

			#####################################################################################################
			#####################################################################################################
			##
			## Do the actual upgrading of packages.  Data is passed in in the form of:
			## package=/path/to/latest.ebuild|/path/to/prior.ebuild|/path/to/other/prior.ebuild&package=...
			##
			elif self.uri == "/upgrade-packages":

				self.PrintHeader()
				self.PrintHTMLHeader("Upgrading Packages... Please wait...")
				for x in string.split(self.form_data,"&"):
					key_and_value = string.split(urllib.unquote(x),"=")
					if len(key_and_value) == 2:
						value = key_and_value[1]
						ebuild_path = string.split(value,"|")[0]

						self.socket.send("<B>" + install_command + " " + ebuild_path + "</B><BR>")
						install_log = os.popen4(install_command + " " + ebuild_path)[1]
						while 1:
							c = install_log.readline()
							if c == "":
								break
							self.socket.send(c + "<BR>")
						self.socket.send("<BR><BR>")   

						for y in string.split(value,"|")[1:]:
							self.socket.send("<B>" + uninstall_command + " " + ebuild_path + " unmerge</B><BR>")
							install_log = os.popen4(uninstall_command + " " + y + " unmerge")[1]
							while 1:
								c = install_log.readline()
								if c == "":
									break
								self.socket.send(c + "<BR>")
							self.socket.send("<BR><BR>")   

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Install a package
			##
			elif self.uri == "/install-package":
				self.PrintHeader()
				self.PrintHTMLHeader("Installing package... Please wait...")

				key_and_value = string.split(urllib.unquote(self.form_data),"=")
				if len(key_and_value) == 2:
					self.socket.send("<B>" + install_command + " " + key_and_value[1] + "</B><BR>")
					install_log = os.popen4(install_command + " " + key_and_value[1])[1]
					while 1:
						c = install_log.readline()
						if c == "":
							break
						self.socket.send(c + "<BR>")
					self.socket.send("<BR><BR>")

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Remove a package
			##
			elif self.uri == "/remove-package":
				self.PrintHeader()
				self.PrintHTMLHeader("Removing package... Please wait...")

				key_and_value = string.split(urllib.unquote(self.form_data),"=")
				if len(key_and_value) == 2:
					self.socket.send("<B>" + uninstall_command + " " + key_and_value[1] + " unmerge</B><BR>")
					install_log = os.popen4(uninstall_command + " " + key_and_value[1] + " unmerge")[1]
					while 1:
						c = install_log.readline()
						if c == "":
							break
						self.socket.send(c + "<BR>")
					self.socket.send("<BR><BR>")

				self.PrintHTMLFooter()


			#####################################################################################################
			#####################################################################################################
			##
			## Print Image
			##
			## NOTE: only works if the image is in /home/warren/python/images/<imagename> and is of type gif
			## NOTE: if you request /images/asdf/fdsa/../../../../../test.asdf, this will try to open
			##	the file /home/warren/python/images/test.asdf  (i.e. it only takes stuff after last /)
			##
			elif self.uri[0:8] == "/images/":
				self.PrintHeader(200,"image/" + self.uri[-3:])

				filename = path_to_graphics + string.split(self.uri,'/')[-1]
				inp = open(filename,"rb")
		
				temp = inp.readlines()
				for x in temp:
					self.socket.send(x)


			#####################################################################################################
			#####################################################################################################
			##
			## Error 404: File Not Found
			##
			else:
				self.PrintHeader(404)
				self.socket.send("<HTML><HEAD>ERROR 404: File Not Found!</BODY></HTML>")

		else:
			self.PrintHeader(401,"text/html;",'WWW-Authenticate: Basic realm="Gentool"')
			self.socket.send("""<HTML><HEAD>
				<TITLE>401 Authorization Required</TITLE>
				</HEAD><BODY>
				<H1>Authorization Required</H1>
				This server could not verify that you
				are authorized to access the document
				requested.  Either you supplied the wrong
				credentials (e.g., bad password), or your
				browser doesn't understand how to supply 
				the credentials required.<P>
				<HR>
				<ADDRESS>""" + server_version + """ Server at localhost Port 80</ADDRESS>
			</BODY></HTML>""")

	def PrintHeader(self,status=200,contenttype="text/html;",extra=""):
		print "Printing server header (status: " + repr(status) + ") \n"
		if status == 200:
			self.socket.send("HTTP/1.1 200 OK\r\n")
		elif status == 401:
			self.socket.send("HTTP/1.1 401 Authorization Required\r\n")
		elif status == 404:
			self.socket.send("HTTP/1.1 404 File Not Found\r\n")

		self.socket.send("Server: " + server_version + "\r\n")
		self.socket.send("Content-Type: " + contenttype + "\r\n")
		if extra != "":
			self.socket.send(extra + "\r\n")
		self.socket.send("\r\n")

	def PrintHTMLHeader(self,title=""):
		self.socket.send("""<HTML>
			<HEAD>
				<TITLE>Gentool</TITLE>
			</HEAD>
			<BODY LEFTMARGIN=0 TOPMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0>
			<TABLE WIDTH="100%" BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100>
			<TR>
				<TD BGCOLOR="#000000">
					<IMG SRC="/images/gentoo.gif" BORDER=0>	
				</TD>
				<TD BGCOLOR="#000000" ALIGN="right" VALIGN="top">
					<BR>
					<A HREF="/" STYLE="text-decoration:none"><FONT COLOR="#ffffff">Home</FONT></A><BR>
					<A HREF="/rsync" STYLE="text-decoration:none"><FONT COLOR="#ffffff">rsync</FONT></A><BR>
					<A HREF="/view-upgrades" STYLE="text-decoration:none"><FONT COLOR="#ffffff">Upgrade Packages</FONT></A><BR>
					<A HREF="/view-installed" STYLE="text-decoration:none"><FONT COLOR="#ffffff">Already Installed Packages</FONT></A><BR>
					<A HREF="/view-available" STYLE="text-decoration:none"><FONT COLOR="#ffffff">Install New Packages</FONT></A><BR>
				</TD>
			</TR>
			<TR>
							<TD BGCOLOR="#000000" COLSPAN=2>
					<TABLE WIDTH="100%" CELLSPACING=0 CELLPADDING=3><TR><TD>
						<FONT COLOR="#00FF00"><B>""" + server_version + " " + title + """</B></FONT>
					</TD></TR></TABLE>
				</TD>
			</TR>
			</TABLE>
			<BR>""")
	def PrintHTMLFooter(self):
		self.socket.send("""<BR><BR></BODY>
			</HTML>""")





class HTTPD:
	def __init__ (self):
		self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		self.socket.bind(('', port))
		self.socket.setblocking (0)
		self.socket.listen(5)
		self.connections = []
	def MainLoop(self):
		# this loop will wait for connections, as well as data on connections...
		# if it gets data on connections, it'll call another function...
		r = []; w = []; e = []

		while 1:
			r,w,e = select.select ([self.socket.fileno()],[self.socket.fileno()],[self.socket.fileno()],0.1)
			if len(r) != 0:
				# new connection
				conn, addr = self.socket.accept()
				self.connections.insert(0,session())
				self.connections[0].socket = conn
				self.connections[0].addr = addr

				print "Connection from", addr
				# if you want to add some ip-checking (localhost only perhaps?), do it here against "addr"

			for x in self.connections:
				# go through existing connections and check for input
				r,w,e = select.select ([x.socket.fileno()],[x.socket.fileno()],[x.socket.fileno()],0.1)
				if len(r) != 0:
					if x.CheckSocketForData() == 1:
						#client dropped the connection... remove it from the list
						self.connections.remove(x)
						print "Client disconnected"

	

temp = HTTPD()
temp.MainLoop()	