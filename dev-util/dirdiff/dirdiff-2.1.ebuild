# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dirdiff/dirdiff-2.1.ebuild,v 1.3 2009/10/12 18:22:00 ssuominen Exp $

DESCRIPTION="Dirdiff is a graphical tool for displaying the differences between
directory trees and for merging changes from one tree into another."
SRC_URI="http://samba.org/ftp/paulus/${P}.tar.gz"
HOMEPAGE="http://samba.org/ftp/paulus/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/tk
		dev-lang/tcl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:CFLAGS=-O3 \(.*\):CFLAGS=${CFLAGS} -fPIC \1:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin dirdiff || die
	dolib.so libfilecmp.so.0.0 || die
	dodoc README
}
