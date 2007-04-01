# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetdude/libnetdude-0.9.ebuild,v 1.2 2007/04/01 21:59:22 vanquirius Exp $

DESCRIPTION="Library for manipulating libpcap/tcpdump trace files"
HOMEPAGE="http://netdude.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/netdude/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="net-libs/libpcapnav
	=dev-libs/glib-1*"

IUSE="doc"

src_compile() {
	econf $(use_enable doc gtk-doc) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO

	use doc || rm -rf "${D}"/usr/share/gtk-doc
}
