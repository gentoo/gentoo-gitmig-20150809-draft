# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/quickswitch/quickswitch-1.0_pre1.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/quickwitch
DESCRIPTION="Utility to switch network profiles on the fly"
SRC_URI="mirror://sourceforge/quickswitch/quickwitch-1.0pre1.tar.gz"
SLOT="0"
LICENSE="GPL-2"
SLOT="0"

HOMEPAGE="http://edgesolutions.ca/"

DEPEND=">=sys-devel/perl-5.6.0"
RDEPEND=${DEPEND}


src_install () {
	cd ${S}
	dobin switchto
	dobin switcher
	dosed "s:/etc/switchto.conf:/etc/quickswitch/switchto.conf:" /usr/bin/switchto
	dosed "s:/etc/switchto.conf:/etc/quickswitch/switchto.conf:" /usr/bin/switcher
	dosed "s:/etc/switchto.last:/etc/quickswitch/switchto.last:" /usr/bin/switchto

	dodir /etc/quickswitch
	insinto /etc/quickswitch
	newins switchto.conf switchto.conf.sample

	doins /etc/init.d
	newins ${FILESDIR}/net.eth0-switchto.rc6 /etc/init.d/net.eth0-switchto

	dodoc README LICENSE
}
