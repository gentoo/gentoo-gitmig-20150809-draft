# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alac_decoder/alac_decoder-0.1.1.ebuild,v 1.1 2006/03/19 21:54:05 sbriesen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Basic decoder for Apple Lossless Audio Codec files (ALAC)"
HOMEPAGE="http://craz.net/programs/itunes/alac.html"
SRC_URI="http://craz.net/programs/itunes/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin alac || die "install failed"
	dodoc README
}
