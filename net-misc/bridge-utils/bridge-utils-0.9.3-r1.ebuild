# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header:

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="http://bridge.sourceforge.net/bridge-utils/${P}.tar.gz"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	make CFLAGS="${CFLAGS}" || die "compile problem"
}

src_install () {
	dosbin brctl/brctl
	doman doc/brctl.8

	insinto /usr/include ; doins libbridge/libbridge.h
	insinto /usr/lib ; doins libbridge/libbridge.a

	dodoc AUTHORS COPYING ChangeLog README THANKS
	dodoc doc/{FAQ,FIREWALL*,HOWTO,PROJECTS,SMPNOTES,TODO,WISHLIST}
}
