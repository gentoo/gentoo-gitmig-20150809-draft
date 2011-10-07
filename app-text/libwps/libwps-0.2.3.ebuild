# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwps/libwps-0.2.3.ebuild,v 1.1 2011/10/07 09:47:21 scarabeus Exp $

EAPI=4

DESCRIPTION="Microsoft Works file word processor format import filter library"
HOMEPAGE="http://libwps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc debug static-libs"

RDEPEND="app-text/libwpd:0.9"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[-nodot] )
"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		$(use_with doc docs) \
		$(use_enable debug)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
