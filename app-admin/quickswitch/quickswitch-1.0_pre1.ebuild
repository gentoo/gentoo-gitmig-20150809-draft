# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/quickswitch/quickswitch-1.0_pre1.ebuild,v 1.12 2003/03/11 21:11:44 seemant Exp $

MY_PN="quickwitch"
MY_P="${MY_PN}-${PV/_/}"
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Utility to switch network profiles on the fly"
SRC_URI="mirror://sourceforge/quickswitch/${MY_P}.tar.gz"
HOMEPAGE="http://edgesolutions.ca/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND=">=dev-lang/perl-5.6.0"

src_install() {
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
