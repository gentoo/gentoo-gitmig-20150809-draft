# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/units/units-1.80.ebuild,v 1.3 2004/02/02 03:42:23 avenj Exp $

DESCRIPTION="program for units conversion and units calculation"
SRC_URI="ftp://ftp.gnu.org/gnu/units/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/units/units.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha ~amd64"

DEPEND=">=sys-libs/readline-4.1-r2
	>=sys-libs/ncurses-5.2-r3"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/remove-script.patch
}

src_compile() {
	#Note: the trailing / is required in the datadir path.
	econf --datadir=/usr/share/${PN}/ || die
	emake || die
}

src_install() {
	einstall datadir=${D}/usr/share/${PN}/ || die
	dodoc ChangeLog NEWS README
}
