# Copyright 1999-2007 Gentoo Foundation and Tim Yamin <plasmaroo@gentoo.org> <plasmaroo@squirrelsoft.org.uk>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/vbs/vbs-1.4.0.ebuild,v 1.3 2007/03/09 22:34:48 calchan Exp $

inherit eutils

HOMEPAGE="http://www.geda.seul.org/tools/vbs/index.html"
DESCRIPTION="vbs - the Verilog Behavioral Simulator"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE="examples"
KEYWORDS="ppc ~x86"

DEPEND=">=sys-devel/flex-2.3
	>=sys-devel/bison-1.22"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc-4.1.patch
}

src_compile () {
	cd src
	econf || die "Configuration failed"
	emake -j1 vbs || die "Compilation failed"
}

src_install () {
	dodoc BUGS CHANGELOG* CONTRIBUTORS COPYRIGHT FAQ README vbs.txt
	dobin src/vbs
	if use examples ; then
		insinto /usr/share/${PF}/examples
		doins EXAMPLES/*
	fi
}
