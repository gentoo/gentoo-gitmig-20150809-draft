# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU Lesser General Public License v2.1
# $Header: 

inherit flag-o-matic 

DESCRIPTION="Libdexter is a plugin-based, distributed sampling library"
HOMEPAGE="http://www.libdexter.org"
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
		$(use_enable doc gtk-doc) || die "econf failed"

	emake -s || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS AUTHORS TODO
}

