# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-0.99.19.ebuild,v 1.4 2002/07/17 09:08:10 seemant Exp $

# If you are looking in here, it is because emerge has instructed you to do
# so.  Please go to http://messenger.yahoo.com/download/unix.html and scroll
# all the way to the bottom.  There, please click on the tar.gz file for
# Debian Sid, and download that file to /usr/portage/distfiles.

MY_P=${PN}_${PV}-1
S=${WORKDIR}/opt/${PN}
DESCRIPTION="Yahoo's instant messenger client"
SRC_URI=""
HOMEPAGE="http://messenger.yahoo.com/messenger/download/unix.html"

DEPEND="gnome? ( gnome-extra/gtkhtml )"
RDEPEND="virtual/x11"

RESTRICT="fetch"

SLOT="0"
LICENSE="yahoo"
KEYWORDS="x86 -ppc -sparc -sparc64"

pkg_setup() {
	if [ ${ARCH} != "x86" ] ; then
		einfo "This is an x86 only package, sorry"
		die "Not supported on your ARCH"
	fi
}

src_unpack() {
	if [ ! -f ${DISTDIR}/${MY_P}.tar.gz ]
	then
		die "Please download ${MY_P} from ${HOMEPAGE} and place into ${DISTDIR}"
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
