# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/dchub-0.1.1.ebuild,v 1.2 2002/07/26 05:08:26 gerk Exp $

S="${WORKDIR}/${P}"

HOMEPAGE="http://www.ac2i.tzo.com/dctc/#dchub"
DESCRIPTION="dchub (Direct Connect Hub), a linux hub for the p2p application dctc (Direct Connect Text Client)."
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc
	=dev-libs/glib-1.2*
	sys-devel/perl
	dev-db/edb"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	einstall || die "install problem"

	dodoc -r Documentation

	dodoc AUTHORS COPYING ChangeLog KNOWN_BUGS NEWS README TODO
}
