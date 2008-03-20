# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/djmount/djmount-0.71-r1.ebuild,v 1.1 2008/03/20 03:34:21 cardoe Exp $

DESCRIPTION="Mount UPnP audio/video servers as a filesystem"
HOMEPAGE="http://djmount.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-fs/fuse
		net-libs/libupnp"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable debug) --with-external-libupnp || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README search_help.txt THANKS
}
