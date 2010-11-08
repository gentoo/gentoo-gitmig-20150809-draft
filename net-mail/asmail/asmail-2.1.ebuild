# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/asmail/asmail-2.1.ebuild,v 1.2 2010/11/08 16:36:07 voyageur Exp $

inherit toolchain-funcs

DESCRIPTION="a small mail monitor similar to xbiff."
HOMEPAGE="http://www.tigr.net"
SRC_URI="http://www.tigr.net/afterstep/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="jpeg"

RDEPEND="dev-libs/openssl
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libICE
	x11-libs/libSM
	jpeg? ( virtual/jpeg )"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_compile() {
	tc-export CC
	econf $(use_enable jpeg)
	emake || die "emake failed."
}

src_install() {
	dobin ${PN}

	newman ${PN}.man ${PN}.1
	newman ${PN}rc.man ${PN}rc.5

	insinto /usr/share/${PN}/pixmaps
	doins pixmaps/cloud-e/*.xpm

	insinto /usr/share/${PN}
	doins -r sounds

	dodoc ${PN}rc.s* CHANGES *.txt README* TODO
}
