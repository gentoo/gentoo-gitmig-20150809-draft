# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.9.1.ebuild,v 1.1 2011/04/20 12:18:02 pacho Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i -e 's: -Wall -Werror -pedantic::g' configure.in || die
	epatch "${FILESDIR}/${P}-gcc46.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		$(use_with doc docs)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
