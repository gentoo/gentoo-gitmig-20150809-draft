# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/hp-web-jetadmin/hp-web-jetadmin-6.5.ebuild,v 1.2 2001/09/28 07:05:23 woodchip Exp $

# *** README ***
#
# This package, in its most basic form (no optional components) will install
# some 4300 files, totalling some 45MB. According to HP the minimum system
# requirements are a 400MHz CPU with 128MB RAM. Note that this uses HP's own
# self-extracting program to install to gentoo's tempdir, during which it
# runs some tests. It will _appear_ like its stuck, but its not. Please be
# patient and wait for it to completely merge. You might see some funny
# debugging information, which potentially looks like an error message.
# Dont worry about that, just ignore it. Furthermore, this package installs
# a whole truckload of doc files into /opt/hp-web-jetadmin/doc, totalling
# some 34MB. The daemon even writes configuration info into that directory
# which you'll notice if you play around with the program, and then unmerge
# it.
#
# I probably need to tweak the depends a little; I couldn't make it install
# on an rc5 box with no X. If you can help, or make any other suggestions
# for this package, feel free.
#
# *** README ***

DESCRIPTION="Remotely install, monitor, and troubleshoot network-connected printers"
HOMEPAGE="http://www.hp.com/go/webjetadmin/"
#
# Hey! These files total 30MB! Biggest one is hpwebjet_linux.selfx, which is 20MB!
# When we get dependency support for SRC_URI, this can be spiffed up a little bit.
# For the time being, if you really wanted to, you could remove stuff from SRC_URI
# below then rebuild the digest by doing: ebuild hp-web-jetadmin-6.5.ebuild digest
#
# The .fpb files are optional components, and total just over 8MB:
#   o wjarda_linux_bundle.fpb: HP Remote Discovery Agent Component
#   o wjapps_linux_bundle.fpb: HP Web Print Server Manager Bundle
#
SRC_URI="http://ftp.hp.com/pub/networking/software/hpwebjet_linux.selfx
         http://ftp.hp.com/pub/networking/software/wjaen_readme.txt
         http://www.hp.com/cposupport/manual_set/bpj06492.pdf
         http://www.hp.com/pond/wja/live/manual/html/wjainfo_rda.html
         http://www.hp.com/pond/wja/live/manual/bundles/wjarda_linux_bundle.fpb
         http://www.hp.com/pond/wja/live/manual/html/wjainfo_pps.html
         http://www.hp.com/pond/wja/live/manual/bundles/wjapps_linux_bundle.fpb"
DEPEND="virtual/glibc"

src_unpack() { :; } ; src_compile() { :; }

src_install() {
	chmod 755 ${DISTDIR}/hpwebjet_linux.selfx

	#
	# Won't install without this hack -- cmon HP you can do better
	# than this. This is really sad. If you donate to me a decent
	# enough printer, I'll do QA/testing for you! :)
	#
	install -m 644 ${FILESDIR}/etc.redhat-release /etc/redhat-release

	#
	# The self-extracting installation program tries to get your
	# hostname automatically. It also configures itself by default
	# to use tcp/8000 unless its already in use by something else.
	# You can change those by supplying the following arguments to
	# the command below if you really want to:
	#
	# -m <name>  Sets the hostname to <name> if <name> is valid
	# -p <num>   Sets the port number to <num> if <num> is valid
	#
	# You can change the port in /opt/hp-web-jetadmin/httpd.ini
	# after installing. Maybe the hostname can be changed too.
	#
	${DISTDIR}/hpwebjet_linux.selfx -s -d ${D}/opt/hp-web-jetadmin-6.5

	#
	# /etc/init.d/hpwebjetd (not in $D) is getting installed by
	# this wonderful self-extracting program. I'd rather remove
	# it now, so a better one can be dropped in without forcing
	# the admin to do the ._cfg tango unconditionally. Man this
	# whole thing is turning out to be a pretty ugly affair.
	#
	rm -f /etc/init.d/hpwebjetd
	exeinto /etc/init.d ; newexe ${FILESDIR}/hpwebjetd-6.5.rc6 hpwebjetd
	
	#
	# This adds an LDPATH entry, which allows you to use the
	# initscript to start the daemon from anywhere. You need
	# not cd /opt/hp-web-jetadmin first.
	#
	insinto /etc/env.d ; doins ${FILESDIR}/20hpwebjetadmin

	#
	# Some docs. Not ideal I know, but at least its something.
	#
	dodoc ${DISTDIR}/wjaen_readme.txt 
	dodoc ${DISTDIR}/bpj06492.pdf
	dodoc ${DISTDIR}/wjainfo_rda.html
	dodoc ${DISTDIR}/wjainfo_pps.html

	#
	# Butcher alert -- this is ridiculous. Ciao baby.
	#
	rm -f /etc/redhat-release
}

#
#  TODO:
#
# o I havent gotten around to working in the optional components
#   yet, but those are next. Im commiting it now so that anybody
#   interested can try it out.
#
# o Maybe leave the /etc/redhat-release file alone (permanently
#   install it) or add some code in src_install to check for it,
#   back it up if there, drop in our file, install, then move
#   the backup back. I dont see the need for this nonsense. Why
#   cant vendors just say you need libc this, ssl that, libfoo
#   this and libbar that.
#
