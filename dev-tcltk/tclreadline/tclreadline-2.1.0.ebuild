# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0.ebuild,v 1.5 2003/04/23 17:05:44 utx Exp $

IUSE=""

DESCRIPTION="readline extension to TCL"

HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/tclreadline/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=dev-lang/tcl-8.3*
	sys-libs/readline"
#S=${WORKDIR}/${PN}-${PV}

src_compile() {
	econf || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	echo "installing tclreadline"
	make DESTDIR=${D} install
}

