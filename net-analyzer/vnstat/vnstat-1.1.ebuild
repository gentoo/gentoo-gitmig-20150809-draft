# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.1.ebuild,v 1.2 2004/06/14 00:02:26 vapier Exp $

DESCRIPTION="network traffic monitor that keeps statistics of daily network traffic"
HOMEPAGE="http://torus.lnet.lut.fi/vnstat/"
SRC_URI="http://torus.lnet.lut.fi/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
