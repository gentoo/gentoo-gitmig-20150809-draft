# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/tkdvd/tkdvd-3.10.1.ebuild,v 1.3 2006/05/28 11:33:00 pylon Exp $

DESCRIPTION="A Tcl/Tk GUI for dvd+rw-tools"
HOMEPAGE="http://regis.damongeot.free.fr/tkdvd/"
SRC_URI="http://regis.damongeot.free.fr/tkdvd/dl/TkDVD-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="app-cdr/dvd+rw-tools
	 dev-lang/tcl
	 dev-lang/tk"

S=${WORKDIR}/tkdvd

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
