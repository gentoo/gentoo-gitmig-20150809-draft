# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dxpc/dxpc-3.9.2.ebuild,v 1.1 2010/01/09 14:57:15 patrick Exp $

DESCRIPTION="an X protocol compressor designed to improve the speed of X11
applications run over low-bandwidth links"
SRC_URI="http://www.vigor.nu/dxpc/${P}.tgz"
HOMEPAGE="http://www.vigor.nu/dxpc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXt
	>=dev-libs/lzo-2"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_install () {
	make prefix="${D}"/usr man1dir="${D}"/usr/share/man/man1 install \
		|| die "make install failed"
	dodoc CHANGES README TODO
}
