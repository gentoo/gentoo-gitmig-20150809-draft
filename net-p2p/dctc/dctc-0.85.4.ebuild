# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.85.4.ebuild,v 1.4 2004/02/02 00:10:43 spock Exp $

DESCRIPTION="Direct Connect Text Client, almost famous file share program"
HOMEPAGE="http://ac2i.tzo.com/dctc/"
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="=dev-libs/glib-2*
	=sys-libs/db-3.2*"

src_install() {
	einstall || die
	dodoc Documentation/* Documentation/DCextensions/*
	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
