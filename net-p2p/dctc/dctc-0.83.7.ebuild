# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.83.7.ebuild,v 1.2 2002/11/04 04:05:03 vapier Exp $

inherit gcc

S=${WORKDIR}/${P}
DESCRIPTION="Direct Connect Text Client, almost famous file share program"
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

newdepend =dev-libs/glib-1.2* =sys-libs/db-3.2*

src_compile() {
	econf
	[ `gcc-major-version` -eq 2 ] && patch -p0 < ${FILESDIR}/${P}-gcc-2.95.patch
	emake || die
}

src_install() {
	einstall || die

	dodoc Documentation/* Documentation/DCextensions/*

	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
