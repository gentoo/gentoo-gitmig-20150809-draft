# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/djmount/djmount-0.71.ebuild,v 1.2 2007/03/01 05:32:15 cardoe Exp $

inherit eutils

DESCRIPTION="mount AV device as a filesystem"
HOMEPAGE="http://djmount.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-fs/fuse
		net-misc/libupnp"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGELOG NEWS README search_help.txt THANKS
}
