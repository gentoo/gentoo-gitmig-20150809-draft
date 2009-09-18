# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dxpc/dxpc-3.8.2-r1.ebuild,v 1.5 2009/09/18 16:34:29 tove Exp $

inherit eutils

DESCRIPTION="an X protocol compressor designed to improve the speed of X11
applications run over low-bandwidth links"
SRC_URI="http://www.vigor.nu/dxpc/3.8.2/${P}.tar.gz"
HOMEPAGE="http://www.vigor.nu/dxpc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="x11-libs/libXt
	>=dev-libs/lzo-2"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-lzo2.patch"
}

src_install () {
	make prefix="${D}"/usr man1dir="${D}"/usr/share/man/man1 install \
		|| die "make install failed"
	dodoc CHANGES README TODO
}
