# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifinfo/wmifinfo-0.09.ebuild,v 1.7 2008/01/16 15:24:09 drac Exp $

inherit toolchain-funcs

DESCRIPTION="a dockapp for monitoring network interfaces."
HOMEPAGE="http://zevv.nl/play/code/wmifinfo"
SRC_URI="http://zevv.nl/play/code/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:" "${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC) ${LDFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
}
