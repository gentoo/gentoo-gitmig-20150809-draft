# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/Eterm/Eterm-0.9.1-r1.ebuild,v 1.1 2002/01/17 20:54:22 g2boojum Exp $

P=Eterm-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A vt102 terminal emulator for X"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz
		 http://www.eterm.org/download/${PN}-bg-${PV}.tar.gz
		 http://www.eterm.org/themes/0.9.1/glass-Eterm-theme.tar.gz"
HOMEPAGE="http://eterm,sourceforge.net"

DEPEND="virtual/glibc
		virtual/x11
		x11-libs/libast
		media-libs/imlib2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack ${PN}-bg-${PV}.tar.gz
}

src_compile() {

    cd ${S}
	# always disable mmx because binutils 2.11.92+ seems to be broken for this package
    ./configure --disable-mmx --prefix=/usr --host=${CHOST} \
	--with-imlib || die
    emake

}

src_install () {

    cd ${S}
	dodir /usr/share/terminfo
    try make DESTDIR=${D} TIC="tic -o ${D}/usr/share/terminfo" install
    dodoc COPYING ChangeLog README ReleaseNotes
    dodoc bg/README.backgrounds
	cd ${D}/usr/share/Eterm/themes
	unpack glass-Eterm-theme.tar.gz
}

