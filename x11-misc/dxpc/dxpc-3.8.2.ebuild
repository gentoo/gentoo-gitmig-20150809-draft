# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dxpc/dxpc-3.8.2.ebuild,v 1.1 2003/11/22 16:11:43 port001 Exp $

IUSE=""

DESCRIPTION="dxpc is an X protocol compressor designed to improve the speed of X11 applications run over low-bandwidth links"
SRC_URI="http://www.vigor.nu/dxpc/3.8.2/${P}.tar.gz"
HOMEPAGE="http://www.vigor.nu/dxpc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=dev-libs/lzo-1.0.8"

RDEPEND="${DEPEND}"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	make prefix=${D}/usr man1dir=${D}/usr/share/man/man1 install || die "Install failed"
	dodoc CHANGES README TODO INSTALL
}

