# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkXwin/tkXwin-1.0-r1.ebuild,v 1.14 2012/06/07 20:43:26 zmedico Exp $

inherit eutils multilib

DESCRIPTION="Tcl/Tk library to detect idle periods of an X session"
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="
	dev-lang/tk
	x11-proto/scrnsaverproto
	x11-proto/xextproto"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-Makefile.in.diff
	epatch "${FILESDIR}"/${PV}-configure.diff
}

src_compile() {
	econf --with-tcl=/usr/$(get_libdir) --with-tk=/usr/$(get_libdir)
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS INSTALL README || die
}
