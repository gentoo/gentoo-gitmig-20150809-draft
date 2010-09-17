# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/chgres/chgres-0.1-r1.ebuild,v 1.1 2010/09/17 01:25:58 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A very simple command line utility for changing X resolutions"
HOMEPAGE="http://hpwww.ec-lyon.fr/~vincent/"
SRC_URI="http://hpwww.ec-lyon.fr/~vincent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXxf86dga
	x11-libs/libXext
	x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	x11-proto/xf86dgaproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-{flags,includes}.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin chgres
	dodoc README
}
