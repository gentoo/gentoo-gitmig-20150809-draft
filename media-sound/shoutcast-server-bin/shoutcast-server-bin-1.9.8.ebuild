# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shoutcast-server-bin/shoutcast-server-bin-1.9.8.ebuild,v 1.6 2009/05/12 11:23:50 ssuominen Exp $

inherit eutils

SVER=${PV//./-}

DESCRIPTION="${PN} is a network streaming server by Nullsoft."
HOMEPAGE="http://www.shoutcast.com/download"
SRC_URI="sc_serv_${PV}_Linux.tar.gz"

LICENSE="shoutcast"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RESTRICT="fetch strip"

RDEPEND=""
DEPEND=""

S=${WORKDIR}

pkg_nofetch() {
	elog "Please download ${A} from:"
	elog "${HOMEPAGE}"
	elog "and move it to ${DISTDIR}"
}

src_compile() { :; }

src_install() {
	# install executable
	elog "Installing Executable"
	dodir /opt/shoutcast
	exeinto /opt/shoutcast
	doexe sc_serv

	#install shoutcast init.d script
	doinitd "${FILESDIR}"/shoutcast

	# install configuration file
	sed -e "s/LogFile=sc_serv\.log/LogFile=\/dev\/null/" -e "s/W3CLog=sc_w3c\.log/W3CLog=\/dev\/null/" -i sc_serv.conf

	# sets screen logging and real time output off since we're running this as a deamon
	sed -e "s:RealTime=1:RealTime=0:" -e "s:ScreenLog=1:ScreenLog=0:" -i sc_serv.conf

	# fixes up messed up example as directories for on demand
	# streaming need a trailing slash at the end of directories
	sed -e "s:; Default is ./content:; Default is ./content/:" -i sc_serv.conf

	# sets up a default content directory for on demand streaming
	dodir /opt/shoutcast/content
	sed -e "s:; ContentDir=./content:ContentDir=/opt/shoutcast/content/:" -i sc_serv.conf

	#install the configuration file
	dodir /etc/shoutcast
	insinto /etc/shoutcast
	doins sc_serv.conf

	# install documentation
	dodoc README.TXT
	cp sc_serv.conf sc_serv.conf.example
	dodoc sc_serv.conf.example

	# Fix permissions - security bug #63551
	fperms 600 /etc/shoutcast/sc_serv.conf
}

pkg_postinst() {
	elog
	elog "To start shoutcast, use the init.d script by running"
	elog "/etc/init.d/shoutcast."
	elog
	elog "On demand content should be stored in /opt/shoutcast/content"
	elog "See http://forums.winamp.com/showthread.php?threadid=75736 for"
	elog "more information on setting up on demand content"
	elog
	elog "FAQ's can be found at:"
	elog "http://forums.winamp.com/showthread.php?threadid=75736 "
	elog "and can help you with server setup."
	elog
	elog "An Gentoo Linux shoutcast guide can be found at "
	elog "http://www.gentoo.org/doc/en/shoutcast-config.xml"
	elog
}
