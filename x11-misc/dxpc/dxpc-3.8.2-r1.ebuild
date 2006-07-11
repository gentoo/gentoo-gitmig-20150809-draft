# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dxpc/dxpc-3.8.2-r1.ebuild,v 1.2 2006/07/11 08:45:47 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="dxpc is an X protocol compressor designed to improve the speed of X11 applications run over low-bandwidth links"
SRC_URI="http://www.vigor.nu/dxpc/3.8.2/${P}.tar.gz"
HOMEPAGE="http://www.vigor.nu/dxpc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"

DEPEND="|| ( (
		x11-proto/xproto
		x11-libs/libXt )
	virtual/x11 )
	>=dev-libs/lzo-2"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-lzo2.patch"
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	make prefix=${D}/usr man1dir=${D}/usr/share/man/man1 install || die "Install failed"
	dodoc CHANGES README TODO
}
