# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/uz2unpack/uz2unpack-0.1.ebuild,v 1.5 2004/11/29 18:40:07 wolf31o2 Exp $

DESCRIPTION="UZ2 Decompressor for UT2003/UT2004"
HOMEPAGE="http://icculus.org/cgi-bin/ezmlm/ezmlm-cgi?42:mss:1013:200406:kikgppboefcimdbadcdo"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT=""
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	einfo "This package is required for ut2003 and ut2004."
}

src_compile() {
	gcc -o ${PN} -Wall ${PN}.c -lz || die "Error compiling"
}

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	doexe uz2unpack
	dodoc README
}
