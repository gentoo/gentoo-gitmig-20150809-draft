# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.1.ebuild,v 1.5 2002/08/16 02:42:02 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TkMan man and info page browser"
SRC_URI="http://tkman.sourceforge.net/${PN}.tar.gz"
HOMEPAGE="http://tkman.sourceforge.net/"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="Artistic"

DEPEND=">=app-text/rman-3.0.9
	>=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake || die
}

src_install () {
	dobin ${PN}
	dobin re${PN}
}
