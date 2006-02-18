# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcapnav/libpcapnav-0.6.ebuild,v 1.2 2006/02/18 17:16:16 vanquirius Exp $

DESCRIPTION="A libpcap wrapper library that allows navigation to arbitrary packets in a tcpdump trace file between reads, using timestamps or percentage offsets."
HOMEPAGE="http://netdude.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdude/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="net-libs/libpcap"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -fr "${D}"/usr/share/gtk-doc
	dodoc AUTHORS ChangeLog README
	use doc && dohtml -r docs/*.css docs/html/*.html docs/images
}
