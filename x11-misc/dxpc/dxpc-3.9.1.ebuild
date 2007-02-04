# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dxpc/dxpc-3.9.1.ebuild,v 1.1 2007/02/04 21:57:31 troll Exp $

IUSE=""

DESCRIPTION="dxpc is an X protocol compressor designed to improve the speed of X11 applications run over low-bandwidth links"
SRC_URI="http://www.vigor.nu/dxpc/${PV}/${P}.tgz"
HOMEPAGE="http://www.vigor.nu/dxpc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="|| ( (
		x11-proto/xproto
		x11-libs/libXt )
	virtual/x11 )
	>=dev-libs/lzo-2"

src_install () {
	make prefix=${D}/usr man1dir=${D}/usr/share/man/man1 install || die "Install failed"
	dodoc CHANGES README TODO
}
