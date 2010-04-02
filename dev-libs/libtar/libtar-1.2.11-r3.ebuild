# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtar/libtar-1.2.11-r3.ebuild,v 1.1 2010/04/02 21:13:50 ssuominen Exp $

EAPI=2
inherit autotools eutils multilib

p_level=6

DESCRIPTION="C library for manipulating tar archives"
HOMEPAGE="http://www.feep.net/libtar/ http://packages.qa.debian.org/libt/libtar.html"
SRC_URI="ftp://ftp.feep.net/pub/software/libtar/${P}.tar.gz
	mirror://debian/pool/main/libt/${PN}/${PN}_${PV}-${p_level}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="static-libs zlib"

DEPEND="zlib? ( sys-libs/zlib )
	!zlib? ( app-arch/gzip )"

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${p_level}.diff
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with zlib)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog* README TODO
	newdoc debian/changelog ChangeLog.debian

	rm -f "${D}"/usr/$(get_libdir)/${PN}.la
}
