# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-0.99.19.1.ebuild,v 1.1 2003/02/14 15:48:56 seemant Exp $

inherit kde

IUSE="kde gnome"

MY_P=${PN}_${PV%.*}-${PV#*.*.*.*}
S=${WORKDIR}/opt/${PN}/bin
DESCRIPTION="Yahoo's instant messenger client"
HOMEPAGE="http://messenger.yahoo.com/messenger/download/unix.html"
SRC_URI="http://download.yahoo.com/dl/unix/linux/debian_sid/${MY_P}.tar.gz"

DEPEND="media-libs/gdk-pixbuf
	gnome-extra/gtkhtml"

RDEPEND="virtual/x11"

SLOT="0"
LICENSE="yahoo"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa"

pkg_setup() {
	if [ ${ARCH} != "x86" ] ; then
		einfo "This is an x86 only package, sorry"
		die "Not supported on your ARCH"
	fi
}

src_compile() {

	cd ${S}
	cp yahoo_gnome.png yahoo.png
	cp yahoo_kde.xpm yahoo.xpm
}

src_install () {
	
	cd ${S}

	into /opt/ymessenger
	dobin ymessenger.bin

	dodir /opt/bin

	insinto /usr/share/pixmaps/mini
	doins yahoo.xpm yahoo.png

	if use gnome
	then
		insinto /usr/share/gnome/apps/Internet
		doins ymessenger.desktop
	fi
	
	if use kde
	then
		insinto ${KDEDIR}/share/applnk/Internet
		doins ymessenger.kdelnk
	fi
}

pkg_postinst() {
	einfo ""
	einfo "If you are upgrading from an older version of ymessenger,"
	einfo "please unmerge the previous version."
	einfo "-=AND=-"
	einfo "mv ~/.ymessenger/preferences ~/.ymessenger/preferences.old"
	einfo ""
}
