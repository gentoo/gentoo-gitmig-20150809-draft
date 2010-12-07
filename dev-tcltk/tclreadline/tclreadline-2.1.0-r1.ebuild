# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0-r1.ebuild,v 1.1 2010/12/07 13:24:20 jlec Exp $

EAPI="3"

inherit autotools

DESCRIPTION="Readline extension to TCL"
HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="mirror://sourceforge/tclreadline/${P}.tar.gz"

LICENSE="BSD"
IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="
	>=dev-lang/tcl-8.3
	sys-libs/readline"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install () {
	emake DESTDIR=${D} install
}
