# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/snitch/snitch-0.0.1.ebuild,v 1.6 2004/07/18 06:01:56 dragonheart Exp $

DESCRIPTION="Snitch is a powerful packetshaping utility that allows the user to easily harness the power of the Linux tc command to shape network traffic"
HOMEPAGE="http://snitch.sourceforge.net/"

SRC_URI="mirror://sourceforge/snitch/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	>=net-firewall/iptables-1.2.9-r1
	sys-apps/iproute2"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin snitch
	doman snitch.1
	dodoc README  docs/*  sample_configs/*
}
