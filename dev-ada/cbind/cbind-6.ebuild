# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ada/cbind/cbind-6.ebuild,v 1.1 2003/07/13 23:53:59 george Exp $

S="${WORKDIR}/${PN}${PV}"
DESCRIPTION="This tool is designed to aid in the creation of Ada bindings to C."
SRC_URI="http://unicoi.kennesaw.edu/ase/ase02_02/tools/${PN}/${PN}${PV}.zip"
HOMEPAGE="http://www.rational.com/"
LICENSE="GMGPL"

DEPEND="dev-lang/gnat"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack "${PN}${PV}.zip"
	cd "${S}"
	patch -p1 < "${FILESDIR}/${PN}${PV}.diff"
}

src_compile() {
	make || die
}

src_install () {
	make PREFIX=${D}/usr/ install || die

	# Install documentation.
	dodoc README
}
