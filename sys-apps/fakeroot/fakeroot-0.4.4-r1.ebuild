# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-0.4.4-r1.ebuild,v 1.6 2003/07/18 20:21:56 vapier Exp $

MY_P="${PN}_${PV}-4.1"

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://joostje.op.het.net/fakeroot/index.html"
SRC_URI="http://ftp.debian.org/debian/dists/potato/main/source/utils/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc ~ppc"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/fakeroot-gcc3-gentoo.patch || die
}

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
}
