# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/quickswitch/quickswitch-0.10.ebuild,v 1.15 2004/02/23 06:11:00 mr_bones_ Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Utility to switch network profiles on the fly"
SRC_URI="mirror://sourceforge/quickswitch/${P}.tar.gz"
HOMEPAGE="http://edgesolutions.ca/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="dev-lang/perl"

src_install() {
	dobin switchto
	dosed "s:/etc/switch.conf:/etc/quickswitch/switch.conf:" /usr/bin/switchto
	dosed "s:/etc/switchto.last:/etc/quickswitch/switchto.last:" /usr/bin/switchto

	exeinto /etc/init.d
	newexe ${FILESDIR}/net.eth0-switchto.rc6 net.eth0-switchto

	dodir /etc/quickswitch
	insinto /etc/quickswitch
	newins switch.conf switch.conf.sample

	dodoc README LICENSE
}
