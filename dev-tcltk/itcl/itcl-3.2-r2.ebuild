# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.2-r2.ebuild,v 1.9 2003/09/09 15:37:19 agriffis Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
SRC_URI="http://dev.scriptics.com/ftp/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.tcltk.com/itcl/"

SLOT="0"
LICENSE="as-is BSD"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="dev-lang/tk"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	econf || die
	make CFLAGS_DEFAULT="${CFLAGS}" || die
}

src_install() {
	einstall || die

	rm ${D}/usr/lib/iwidgets
	ln -s iwidgets3.0.1 ${D}/usr/lib/iwidgets
	dodoc CHANGES INCOMPATIBLE README TODO license.terms
	dodoc doc/*
}
