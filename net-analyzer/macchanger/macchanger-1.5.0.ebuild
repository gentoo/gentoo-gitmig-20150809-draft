# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/macchanger/macchanger-1.5.0.ebuild,v 1.8 2007/07/11 23:49:24 mr_bones_ Exp $

DESCRIPTION="Utility for viewing/manipulating the MAC address of network interfaces"
HOMEPAGE="http://www.alobbs.com/macchanger"
SRC_URI="mirror://gnu/macchanger/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	# Shared data is installed below /lib, see Bug #57046
	econf \
		--bindir=/sbin \
		--datadir=/lib \
		|| die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README

	dodir /usr/bin
	dosym /sbin/macchanger /usr/bin/macchanger
	dosym /lib/macchanger /usr/share/macchanger
}
