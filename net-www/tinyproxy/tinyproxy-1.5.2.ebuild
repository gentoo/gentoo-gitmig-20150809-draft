# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.5 2002/04/29 22:56:53 sandymac Exp

DESCRIPTION="lightweight HTTP/SSL proxy"
SRC_URI="mirror://sourceforge/tinyproxy/${P}.tar.gz"
HOMEPAGE="http://tinyproxy.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="socks5"

DEPEND="socks5? ( net-misc/dante )"

src_compile() {
	econf \
		--enable-xtinyproxy \
		--enable-filter \
		--enable-tunnel \
		--enable-upstream \
		`use_enable socks5 socks` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
