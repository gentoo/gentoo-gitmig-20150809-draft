# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/tkdvd/tkdvd-3.4.ebuild,v 1.1 2005/04/27 00:07:16 pylon Exp $

DESCRIPTION="A Tcl/Tk GUI for dvd+rw-tools"
HOMEPAGE="http://regis.damongeot.free.fr/tkdvd/"
SRC_URI="http://regis.damongeot.free.fr/tkdvd/dl/TkDVD-3.4.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="app-cdr/dvd+rw-tools
	 dev-lang/tcl"

S=${WORKDIR}/TkDVD

src_compile() {
	einfo "Nothing to compile!"
}

src_install() {
	insinto /usr/share/${PF}/src
	doins src/*

	exeinto /usr/share/${PF}
	doexe TkDVD.sh

	dodir /usr/bin

	cat <<EOF >${D}/usr/bin/tkdvd
#!/bin/sh
cd /usr/share/${PF}
./TkDVD.sh
EOF

	fperms 755 /usr/bin/tkdvd

	dodoc COPYING ChangeLog FAQ INSTALL README TODO doc/config_file

	insinto /usr/share/pixmaps
	doins icons/*.png
}
