# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dirdiff/dirdiff-1.6.ebuild,v 1.2 2004/06/25 02:29:13 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Dirdiff is a graphical tool for displaying the differences between
directory trees and for merging changes from one tree into another."
SRC_URI="http://samba.org/ftp/paulus/${PN}-${PV}.tar.gz"
HOMEPAGE="http://samba.org/ftp/paulus/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="dev-lang/tk
		dev-lang/tcl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	make all

}

src_install() {
	cd ${S}
	make install
	dodoc README
}
