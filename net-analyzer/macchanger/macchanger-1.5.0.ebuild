# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/macchanger/macchanger-1.5.0.ebuild,v 1.1 2004/07/24 13:58:11 eldad Exp $

DESCRIPTION="Utility for viewing/manipulating the MAC address of network interfaces"
HOMEPAGE="http://www.alobbs.com/macchanger"
LICENSE="GPL-2"

SRC_URI="ftp://ftp.gnu.org/gnu/macchanger/${P}.tar.gz"
KEYWORDS="~x86 ~ppc ~sparc"
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
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	dodir /usr/bin
	dosym /sbin/macchanger /usr/bin/macchanger
	dosym /lib/macchanger /usr/share/macchanger
}
