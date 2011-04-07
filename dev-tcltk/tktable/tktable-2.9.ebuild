# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tktable/tktable-2.9.ebuild,v 1.6 2011/04/07 15:01:37 jlec Exp $

MY_P="Tktable${PV}"
DESCRIPTION="full-featured 2D table widget"
HOMEPAGE="http://tktable.sourceforge.net/"
SRC_URI="mirror://sourceforge/tktable/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tk-8.0"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/relid'/relid/" "${S}"/{configure,tclconfig/tcl.m4} || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
