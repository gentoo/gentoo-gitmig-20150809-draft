# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmsysmon/wmsysmon-0.7.6.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMaker DockUp to monitor: Memory usage, Swap usage, I/O throughput, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"
DEPEND="virtual/glibc x11-base/xfree"
#RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86

src_compile() {
	make -C src
}

src_install () {
	dobin src/wmsysmon
	dodoc COPYING  ChangeLog  FAQ  README
}
