# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-2.3.1.ebuild,v 1.1 2003/05/08 03:04:49 mkeadle Exp $

IUSE="nls"

inherit commonbox eutils

S=${WORKDIR}/${P}
DESCRIPTION=" Openbox is a window manager with an enhanced Blackbox style-engine that supports the KDE and GNOME2 desktop environments and their applications. It provides a familiar environment to Blackbox users with added customizability."
SRC_URI="http://icculus.org/openbox/releases/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/"

SLOT="2"
LICENSE="BSD"
KEYWORDS="~x86 ppc sparc"

DEPEND="$DEPEND
	virtual/xft"

mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-epist.patch

}

#src_compile() {

#	commonbox_src_compile

#}

src_install() {

    commonbox_src_install

	rm -f ${D}/usr/share/man/man1/xftlsfonts*
	mv ${D}/usr/share/commonbox/openbox/epistrc \
		${D}/usr/share/commonbox/epistrc.default
	rmdir ${D}/usr/share/commonbox/${PN}
	rmdir ${D}/usr/share/commonbox/${MYBIN}

	insinto /usr/share/commonbox/buttons
	doins ${S}/data/buttons/*.xbm

}
