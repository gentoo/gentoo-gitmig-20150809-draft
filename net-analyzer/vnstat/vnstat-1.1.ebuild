# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.1.ebuild,v 1.4 2004/07/13 06:41:16 eldad Exp $

DESCRIPTION="network traffic monitor that keeps statistics of daily network traffic"
HOMEPAGE="http://torus.lnet.lut.fi/vnstat/"
SRC_URI="http://torus.lnet.lut.fi/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /var/spool/vnstat
	dobin src/vnstat
	newdoc cron/vnstat vnstat-samplecron
	dodoc CHANGES README UPGRADE
}
