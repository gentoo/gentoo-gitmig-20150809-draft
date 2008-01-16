# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmget/wmget-0.6.0.ebuild,v 1.8 2008/01/16 01:17:43 drac Exp $

inherit toolchain-funcs

DESCRIPTION="a libcurl based dockapp for automated downloads."
HOMEPAGE="http://amtrickey.net/wmget/"
SRC_URI="http://amtrickey.net/download/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	>=net-misc/curl-7.9.7"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed -i -e "s:ar rc:$(tc-getAR) rc:" "${S}"/dockapp/Makefile
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc NEWS README TODO
}
