# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipx-utils/ipx-utils-1.1-r2.ebuild,v 1.1 2004/10/29 00:38:54 vapier Exp $

inherit eutils

DESCRIPTION="The IPX Utilities"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/${P/-utils}.tar.gz"

LICENSE="Caldera"
SLOT="0"
KEYWORDS="ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${P/-utils}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:-O2 -Wall:${CFLAGS}:" Makefile
	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-proc.patch #67642
}

src_install() {
	dodir /sbin /usr/share/man/man8
	make DESTDIR=${D} install || die

	insinto /etc/conf.d ; newins ${FILESDIR}/ipx.confd ipx
	exeinto /etc/init.d ; newexe ${FILESDIR}/ipx.init ipx

	dodoc README
}
