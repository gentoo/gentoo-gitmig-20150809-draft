# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.83.8.ebuild,v 1.3 2003/02/13 15:18:30 vapier Exp $

DESCRIPTION="Direct Connect Text Client, almost famous file share program"
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=dev-libs/glib-1.2*
	=sys-libs/db-3.2*"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc Documentation/* Documentation/DCextensions/*
	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
