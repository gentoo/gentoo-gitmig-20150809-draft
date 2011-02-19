# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/check/check-0.9.8.ebuild,v 1.4 2011/02/19 19:21:45 maekke Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A unit test framework for C"
HOMEPAGE="http://sourceforge.net/projects/check/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="static-libs"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.9.6-AM_PATH_CHECK.patch \
		"${FILESDIR}"/${PN}-0.9.6-64bitsafe.patch

	sed -i -e '/^docdir =/d' {.,doc}/Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS *ChangeLog* NEWS README THANKS TODO

	rm -f "${D}"/usr/share/doc/${PF}/COPYING*
	find "${D}" -name '*.la' -exec rm -f {} +
}
