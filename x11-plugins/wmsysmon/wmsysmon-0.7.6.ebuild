# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsysmon/wmsysmon-0.7.6.ebuild,v 1.3 2003/09/06 05:56:25 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="WMaker DockUp to monitor: Memory usage, Swap usage, I/O throughput, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	make -C src
}

src_install () {
	dobin src/wmsysmon
	dodoc COPYING  ChangeLog  FAQ  README
}
