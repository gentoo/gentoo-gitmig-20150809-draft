# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsysmon/wmsysmon-0.7.6-r2.ebuild,v 1.3 2004/07/18 23:55:59 kloeri Exp $

inherit eutils
IUSE=""
DESCRIPTION="WMaker DockUp to monitor: CPU, Memory, Swap usage, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc alpha ~amd64 ~ppc"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# bug #27499
	# epatch ${FILESDIR}/fanta.diff
	# this will be addressed in s4t4n.patch

	# bug 48851
	epatch ${FILESDIR}/${P}-s4t4n.patch
}

src_compile()
{
	sed -i 's/^CFLAGS/#CFLAGS/' src/Makefile
	make -C src
}

src_install ()
{
	dobin src/wmsysmon
	dodoc COPYING ChangeLog FAQ README
}
