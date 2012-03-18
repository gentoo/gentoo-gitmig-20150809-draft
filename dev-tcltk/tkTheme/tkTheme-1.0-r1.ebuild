# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkTheme/tkTheme-1.0-r1.ebuild,v 1.9 2012/03/18 18:34:57 armin76 Exp $

inherit eutils

DESCRIPTION="Tcl/Tk Theming library."
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/other/"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/other/${PN}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	x11-libs/libXpm"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

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
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
