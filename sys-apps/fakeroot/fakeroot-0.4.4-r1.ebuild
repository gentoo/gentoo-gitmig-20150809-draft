# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-0.4.4-r1.ebuild,v 1.14 2004/10/30 04:34:02 agriffis Exp $

inherit gnuconfig eutils

MY_P="${PN}_${PV}-4.1"

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://joostje.op.het.net/fakeroot/index.html"
SRC_URI="mirror://debian/dists/potato/main/source/utils/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha amd64 ~ia64"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fakeroot-gcc3-gentoo.patch
	epatch ${FILESDIR}/${P}-faked.patch
	gnuconfig_update
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
}
