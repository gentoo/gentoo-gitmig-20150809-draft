# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwps/libwps-0.2.2.ebuild,v 1.2 2011/07/09 18:03:01 pacho Exp $

EAPI="4"

inherit autotools

DESCRIPTION="Microsoft Works file word processor format import filter library"
HOMEPAGE="http://libwps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug"

RDEPEND="app-text/libwpd:0.9"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[-nodot] )
"

src_prepare() {
	sed -i -e 's: -Werror::' configure.in || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--docdir=/usr/share/doc/${PF} \
		$(use_with doc docs) \
		$(use_enable debug)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
