# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-0.99.19-r2.ebuild,v 1.1 2002/07/03 01:53:31 owen Exp $

# If you are looking in here, it is because emerge has instructed you to do
# so.  Please go to http://messenger.yahoo.com/download/unix.html and scroll
# all the way to the bottom.  There, please click on the tar.gz file for
# Debian Sid, and download that file to /usr/portage/distfiles.

MY_P=${PN}_${PV}-1
S=${WORKDIR}/opt/${PN}
DESCRIPTION="Yahoo's instant messenger client"
SRC_URI="http://download.yahoo.com/dl/unix/linux/debian_sid/ymessenger_0.99.19-1.tar.gz"
HOMEPAGE="http://messenger.yahoo.com/messenger/download/unix.html"

DEPEND="gnome? ( gnome-extra/gtkhtml )"
RDEPEND="virtual/x11"


SLOT="0"
LICENSE="yahoo"

src_unpack() {
	if [ ${ARCH} != "x86" ]
	then
		einfo "Sorry, this one is x86 only"
		die
	fi
	unpack ${MY_P}.tar.gz || die
}

src_compile() {
	cd bin
	cp yahoo_gnome.png yahoo.png
	cp yahoo_kde.xpm yahoo.xpm

	#use kde && ( \
	#	mv ymessenger.kdelnk ymessenger.kdelnk.old
	#	sed "s:^Ic.*:Icon=${KDEDIR}/share/icons/hicolor/48x48/apps/yahoo.png:" \
	#		ymessenger.kdelnk.old > ymessenger.kdelnk
	#)
	
	#use gnome && ( \
	#	mv ymessenger.desktop ymessenger.desktop.old
	#	sed "s:Icon.*:Icon=/usr/share/pixmaps/yahoo.xpm:" \
	#		ymessenger.desktop.old > ymessenger.desktop
	#)
}

src_install () {

	insinto /opt/ymessenger/bin
	doins bin/*

	exeinto /opt/ymessenger/bin
	doexe bin/ymessenger
	doexe bin/ymessenger.bin

	cp -a lib ${D}/opt/${PN}
	
	#use gnome && ( \
	#	insinto /usr/share/gnome/apps/Internet
	#	doins ymessenger.desktop
#
#		insinto /usr/share/pixmaps
#		doins yahoo.xpm
#	) || (
#		dohtml yahoo.xpm
#	)
	
#	use kde && ( \
#		insinto ${KDEDIR}/share/applnk/Applications
#		doins ymessenger.kdelnk
#
#		insinto ${KDEDIR}/share/icons/hicolor/48x48/apps
#		doins yahoo.png
#	) || (
#		dohtml yahoo.png
#	)

	dodir /etc/env.d
	echo "PATH=/opt/ymessenger/bin" > ${D}/etc/env.d/97ymessenger
}

pkg_postinst() {

	einfo "If you are upgrading from an old version of ymessenger, please"
	einfo "remove the older version.  Also, please do this: "
	einfo "mv ~/.ymessenger/preferences ~/.ymessenger/preferences.old"
}
