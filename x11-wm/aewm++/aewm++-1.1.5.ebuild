# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm++/aewm++-1.1.5.ebuild,v 1.1 2008/05/03 20:53:44 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A window manager with more modern features than aewm but with the same look and feel."
HOMEPAGE="http://frankhale.org"
SRC_URI="http://frankhale.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i -e "s:install -s:install:" Makefile \
		|| die "sed failed."
}

src_compile() {
	emake CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" LDPATH="" \
		ADDITIONAL_CFLAGS="" INCLUDES="" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README
}
