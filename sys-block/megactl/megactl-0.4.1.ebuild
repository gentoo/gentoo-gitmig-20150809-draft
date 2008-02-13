# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megactl/megactl-0.4.1.ebuild,v 1.2 2008/02/13 10:01:22 wschlich Exp $

inherit eutils

IUSE=""
DESCRIPTION="LSI MegaRAID control utility"
HOMEPAGE="http://sourceforge.net/projects/megactl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch
}

src_compile() {
	cd src
	emake || die "make failed"
}

src_install() {
	cd src
	dosbin megactl megasasctl megatrace
	dodoc megarpt megasasrpt README
}
