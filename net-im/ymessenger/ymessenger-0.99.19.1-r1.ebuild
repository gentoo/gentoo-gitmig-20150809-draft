# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-0.99.19.1-r1.ebuild,v 1.3 2003/09/05 23:58:58 msterret Exp $

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
}

src_install () {
	cd ${S}

	into /opt/ymessenger
	newbin ymessenger.bin ymessenger

	insinto /opt/ymessenger/bin
	doins yahoo_kde.xpm yahoo_gnome.png

	insinto /opt/ymessenger/bin
	doins ymessenger.desktop

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
