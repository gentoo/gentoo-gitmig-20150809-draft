# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsysmon/wmsysmon-0.7.6.ebuild,v 1.6 2004/06/19 04:07:07 kloeri Exp $

DESCRIPTION="WMaker DockUp to monitor: Memory usage, Swap usage, I/O throughput, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"

DEPEND="virtual/x11"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

src_compile() {
	make -C src
}

src_install () {
	dobin src/wmsysmon
	dodoc COPYING  ChangeLog  FAQ  README
}
