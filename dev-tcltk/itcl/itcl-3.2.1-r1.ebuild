# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.2.1-r1.ebuild,v 1.4 2004/04/04 22:20:38 zx Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}_src.tgz"
HOMEPAGE="http://www.tcltk.com/${PN}/"

SLOT="0"
LICENSE="as-is BSD"
KEYWORDS="x86 ~ppc sparc"
DEPEND="dev-lang/tk"
PDEPEND="dev-tcltk/iwidgets"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	# fix an undefined const glitch for Tcl8.3
	sed -i '1004h;1004d;1006G' ${S}/itcl/generic/itcl_class.c
}

src_compile() {
	econf || die "econf failed"
	emake DESTDIR="${D}" CFLAGS_DEFAULT="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die	"make install failed"
	dodoc CHANGES INCOMPATIBLE README TODO license.terms
	dodoc doc/*
	dosym /usr/lib/itcl3.2 /usr/lib/itcl
	dosym /usr/lib/itk3.2 /usr/lib/itk
}
