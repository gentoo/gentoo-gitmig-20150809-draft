# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dctc/dctc-0.83.1.ebuild,v 1.5 2002/10/04 06:16:59 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Direct Connect Text Client, almost famous file share program."
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"


DEPEND="=dev-libs/glib-1.2*
	=sys-libs/db-3.2*"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc -r Documentation

	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
