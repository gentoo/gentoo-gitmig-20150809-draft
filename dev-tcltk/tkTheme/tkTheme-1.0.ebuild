# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkTheme/tkTheme-1.0.ebuild,v 1.10 2004/06/25 02:10:40 agriffis Exp $

inherit eutils

DESCRIPTION="Tcl/Tk Theming library."
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/other/"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/other/${PN}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 alpha ~sparc"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.in.diff
}

src_compile() {
	econf --with-tcl=/usr/lib --with-tk=/usr/lib || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
