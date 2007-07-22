# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsysmon/wmsysmon-0.7.6-r3.ebuild,v 1.11 2007/07/22 04:26:48 dberkholz Exp $

inherit eutils

IUSE="high-ints"
DESCRIPTION="WMaker DockUp to monitor: CPU, Memory, Swap usage, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz
	mirror://gentoo/${P}-s4t4n.patch.bz2"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ppc ppc64"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# bug 48851
	epatch ${WORKDIR}/${P}-s4t4n.patch

	# Monitor all the 24 interrupts on alpha and x86 SMP machines
	if use alpha || use high-ints; then
		cd src
		epatch ${FILESDIR}/${PN}-high-ints.patch
	fi
}

src_compile()
{
	GENTOO_CFLAGS="${CFLAGS}" make -C src
}

src_install ()
{
	dobin src/wmsysmon
	dodoc ChangeLog FAQ README
}
