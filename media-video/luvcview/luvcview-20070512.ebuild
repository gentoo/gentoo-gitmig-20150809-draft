# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/luvcview/luvcview-20070512.ebuild,v 1.3 2010/06/21 16:46:27 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="USB Video Class grabber"
HOMEPAGE="http://linux-uvc.berlios.de"
SRC_URI="http://mxhaard.free.fr/spca50x/Investigation/uvc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_prepare() {
	sed -i -e 's/-O2//' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" CPP="$(tc-getCXX)" || die
}

src_install() {
	dobin luvcview || die
	dodoc README Changelog ToDo
}
