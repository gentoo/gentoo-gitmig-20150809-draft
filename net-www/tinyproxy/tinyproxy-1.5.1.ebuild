# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tinyproxy/tinyproxy-1.5.1.ebuild,v 1.3 2003/06/12 22:07:38 msterret Exp $

DESCRIPTION="lightweight HTTP/SSL proxy"
SRC_URI="mirror://sourceforge/tinyproxy/${P}.tar.gz"
HOMEPAGE="http://tinyproxy.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="socks5"

DEPEND="socks5? ( net-misc/dante )"

src_compile() {
	local myconf="--enable-xtinyproxy --enable-filter --enable-tunnel --enable-upstream"
	use socks5 \
		&& myconf="${myconf} --enable-socks" \
		|| myconf="${myconf} --disable-socks"
	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
