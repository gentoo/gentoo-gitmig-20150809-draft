# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkXwin/tkXwin-1.0-r2.ebuild,v 1.1 2010/12/07 17:20:57 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Tcl/Tk library to detect idle periods of an X session."
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"

IUSE="debug threads"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="
	dev-lang/tk[threads?]
	x11-proto/scrnsaverproto
	x11-proto/xextproto"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-Makefile.in.diff \
		"${FILESDIR}"/${PV}-configure.patch
	tc-export CC
}

src_configure() {
	econf \
		--with-tcl=/usr/$(get_libdir) \
		--with-tk=/usr/$(get_libdir) \
		--enable-gcc \
		--with-x \
		--enable-shared \
		$(use_enable threads) \
		$(use_enable debug symbols)
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README || die
}
