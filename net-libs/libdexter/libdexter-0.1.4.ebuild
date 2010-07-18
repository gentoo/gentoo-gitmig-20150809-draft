# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libdexter/libdexter-0.1.4.ebuild,v 1.4 2010/07/18 06:13:39 dragonheart Exp $

inherit flag-o-matic

DESCRIPTION="Libdexter is a plugin-based, distributed sampling library"
HOMEPAGE="http://libdexter.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdexter/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=dev-libs/glib-2.10
	doc? (
		>=dev-util/gtk-doc-1.6
		~app-text/docbook-xml-dtd-4.1.2
	)"

src_compile() {
	econf \
		$(use_enable doc gtk-doc) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS AUTHORS TODO
}
