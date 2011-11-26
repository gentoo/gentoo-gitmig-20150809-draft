# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.7-r2.ebuild,v 1.2 2011/11/26 09:31:20 hwoarang Exp $

EAPI="3"

inherit eutils libtool

DESCRIPTION="Flexible remote checksum-based differencing"
HOMEPAGE="http://librsync.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/popt"

src_prepare() {
	# Bug #142945
	epatch "${FILESDIR}"/${P}-huge-files.patch

	# Bug #185600
	elibtoolize
	epunt_cxx
}

src_configure() {
	econf --enable-shared $(use_enable static-libs static) || die
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc NEWS AUTHORS THANKS README TODO
	if ! use static-libs; then
		rm -f "${D}"/usr/lib/librsync.la || die
	fi
}
