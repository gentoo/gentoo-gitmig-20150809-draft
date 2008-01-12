# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/luvcview/luvcview-20070512.ebuild,v 1.1 2008/01/12 13:02:19 agorf Exp $

inherit toolchain-funcs

DESCRIPTION="USB Video Class grabber"
HOMEPAGE="http://linux-uvc.berlios.de"
SRC_URI="http://mxhaard.free.fr/spca50x/Investigation/uvc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	sed -e 's/-O2//' -i "${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CPP="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	dobin luvcview
	dodoc README Changelog ToDo
}
