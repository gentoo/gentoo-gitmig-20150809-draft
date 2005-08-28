# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-base/jabber-base-0.00.ebuild,v 1.1 2005/08/28 16:08:53 humpback Exp $

inherit eutils

DESCRIPTION="Jabber servers and transports layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}"

#Info for people working in jabber related packages

#/etc/jabber/ for configuration files
#/var/run/jabber/ for the pid files
#/var/spool/jabber/ for the flat files databases (actually there must be a ewarn
#at end of ebuild telling user to creat /var/spool/jabber/JID, as some transports fail to start if
#the directory is not there, even if they have permissions to creat it)
#/var/log/jabber/ for the log files

#for the python based transports with no install script:
#they must inherit python, run python_version() and be installed in:
#/usr/lib/python${PYVER}/site-packages/$package-name

#the user should be the one created here username=group=jabber


src_install() {
	# Add our default jabber group and user
	enewgroup jabber
	enewuser jabber -1 -1 -1 jabber

	keepdir /etc/jabber
	keepdir /var/run/jabber
	keepdir /var/spool/jabber
	keepdir /var/log/jabber

	fowners jabber:jabber /etc/jabber /var/log/jabber /var/spool/jabber /var/run/jabber
	fperms 770 /etc/jabber /var/log/jabber /var/spool/jabber /var/run/jabber
}
