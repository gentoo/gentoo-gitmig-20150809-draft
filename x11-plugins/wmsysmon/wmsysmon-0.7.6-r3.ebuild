# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsysmon/wmsysmon-0.7.6-r3.ebuild,v 1.1 2004/08/02 12:07:02 s4t4n Exp $

inherit eutils

IUSE="high-ints"
DESCRIPTION="WMaker DockUp to monitor: CPU, Memory, Swap usage, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~alpha ~amd64 ~ppc"

DEPEND="virtual/x11"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# bug 48851
	epatch ${FILESDIR}/${P}-s4t4n.patch

	# Monitor all the 24 interrupts on alpha and x86 SMP machines
	if use alpha || use high-ints; then
		cd src
		epatch ${FILESDIR}/${P}-high-ints.patch
	fi
}

src_compile()
{
	GENTOO_CFLAGS="${CFLAGS}" make -C src
}

src_install ()
{
	dobin src/wmsysmon
	dodoc COPYING ChangeLog FAQ README
}
