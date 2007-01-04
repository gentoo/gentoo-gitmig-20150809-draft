# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsplusutils/hfsplusutils-1.0.4-r1.ebuild,v 1.12 2007/01/04 18:23:05 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit autotools eutils libtool

MY_P="hfsplus_${PV}"
DESCRIPTION="HFS+ Filesystem Access Utilities (a PPC filesystem)"
HOMEPAGE="http://penguinppc.org/historical/hfsplus/"
SRC_URI="http://penguinppc.org/historical/hfsplus/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64"
IUSE=""

DEPEND="app-arch/bzip2"
RDEPEND="virtual/libc"

S=${WORKDIR}/hfsplus-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/hfsplusutils-1.0.4-glob.patch
	epatch ${FILESDIR}/hfsplusutils-1.0.4-errno.patch
	epatch ${FILESDIR}/hfsplusutils-1.0.4-gcc4.patch

	eautoreconf
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man
	make \
		prefix=${D}/usr \
		libdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	newman doc/man/hfsp.man hfsp.1
}
