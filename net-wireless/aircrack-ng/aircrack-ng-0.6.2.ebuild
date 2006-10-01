# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack-ng/aircrack-ng-0.6.2.ebuild,v 1.1 2006/10/01 22:40:15 genstef Exp $

inherit toolchain-funcs eutils

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://download.aircrack-ng.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	emake -e CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake prefix=/usr docdir="/usr/share/doc/${PF}" mandir="/usr/share/man/man1" destdir="${D}" install doc \
		|| die "emake install failed"
}
