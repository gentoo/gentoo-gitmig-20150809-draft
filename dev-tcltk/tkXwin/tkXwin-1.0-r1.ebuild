# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkXwin/tkXwin-1.0-r1.ebuild,v 1.3 2007/01/03 03:31:45 beandog Exp $

inherit eutils

DESCRIPTION="Tcl/Tk library to detect idle periods of an X session."
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.in.diff
	epatch ${FILESDIR}/${PV}-configure.diff
}

src_compile() {
	econf --with-tcl=/usr/$(get_libdir) --with-tk=/usr/$(get_libdir) || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README
}
