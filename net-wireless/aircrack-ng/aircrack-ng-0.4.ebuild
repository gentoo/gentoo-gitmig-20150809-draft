# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack-ng/aircrack-ng-0.4.ebuild,v 1.2 2006/04/19 17:00:03 dang Exp $

inherit toolchain-funcs eutils

DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://download.aircrack-ng.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	emake -e CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make prefix=/usr docdir="/usr/share/doc/${PF}" destdir="${D}" install \
		|| die "make install failed"
}
