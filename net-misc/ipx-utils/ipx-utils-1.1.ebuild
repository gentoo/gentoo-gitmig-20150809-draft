# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipx-utils/ipx-utils-1.1.ebuild,v 1.6 2003/09/05 22:01:48 msterret Exp $

S=${WORKDIR}/${P/-utils}
DESCRIPTION="The IPX Utilities"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/system/filesystems/ncpfs/${P/-utils}.tar.gz"

LICENSE="Caldera"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

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

