# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dirdiff/dirdiff-1.6.ebuild,v 1.4 2004/07/18 15:51:14 tgall Exp $

inherit eutils

DESCRIPTION="Dirdiff is a graphical tool for displaying the differences between
directory trees and for merging changes from one tree into another."
SRC_URI="http://samba.org/ftp/paulus/${PN}-${PV}.tar.gz"
HOMEPAGE="http://samba.org/ftp/paulus/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="dev-lang/tk
		dev-lang/tcl"
RDEPEND="${DEPEND}"
IUSE=""

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
