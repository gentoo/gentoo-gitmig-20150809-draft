# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0.ebuild,v 1.16 2010/12/07 13:25:45 jlec Exp $

DESCRIPTION="Readline extension to TCL"
HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="mirror://sourceforge/tclreadline/${P}.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"

DEPEND="
	>=dev-lang/tcl-8.3
	sys-libs/readline"
RDEPEND="${DEPEND}"

src_compile() {
	econf
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	emake DESTDIR=${D} install || die
}
