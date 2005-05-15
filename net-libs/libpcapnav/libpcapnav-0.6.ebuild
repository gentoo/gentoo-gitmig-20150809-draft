# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcapnav/libpcapnav-0.6.ebuild,v 1.1 2005/05/15 01:15:49 vanquirius Exp $

DESCRIPTION="A libpcap wrapper library that allows navigation to arbitrary packets in a tcpdump trace file between reads, using timestamps or percentage offsets."
HOMEPAGE="http://netdude.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdude/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="virtual/libpcap"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -fr ${D}/usr/share/gtk-doc
	dodoc AUTHORS ChangeLog INSTALL README
	use doc && dohtml -r docs/*.css docs/html/*.html docs/images
}
