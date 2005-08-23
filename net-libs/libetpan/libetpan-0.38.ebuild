# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libetpan/libetpan-0.38.ebuild,v 1.4 2005/08/23 15:19:47 ticho Exp $

DESCRIPTION="A portable, efficient middleware for different kinds of mail access."
HOMEPAGE="http://libetpan.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="berkdb debug ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	db? ( sys-libs/db )"

src_compile() {
	local myconf

	econf \
		`use_enable debug` \
		`use_enable berkdb db` \
		`use_with ssl openssl` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc NEWS TODO ChangeLog
}
