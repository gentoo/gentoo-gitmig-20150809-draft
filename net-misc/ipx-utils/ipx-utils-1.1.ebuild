# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipx-utils/ipx-utils-1.1.ebuild,v 1.10 2004/07/22 22:27:49 tgall Exp $

S=${WORKDIR}/${P/-utils}
IUSE=""
DESCRIPTION="The IPX Utilities"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/${P/-utils}.tar.gz"

LICENSE="Caldera"
SLOT="0"
KEYWORDS="x86 sparc s390 ppc64"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix CFLAGS
	cp Makefile Makefile.orig
	sed -e "s:-O2 -Wall:${CFLAGS}:" \
		Makefile.orig > Makefile

	# Fix install locations
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	emake || die
}

src_install() {
	dodir /sbin /usr/share/man/man8
	make DESTDIR=${D} install || die

	insinto /etc/conf.d
	newins ${FILESDIR}/ipx.confd ipx
	exeinto /etc/init.d
	newexe ${FILESDIR}/ipx.init ipx

	dodoc COPYING README
}

