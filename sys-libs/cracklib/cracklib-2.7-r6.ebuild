# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r6.ebuild,v 1.3 2002/12/09 22:47:16 azarah Exp $

S="${WORKDIR}/cracklib,${PV}"
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/cracklib2_${PV}.orig.tar.gz"
HOMEPAGE="http://www.users.dircon.co.uk/~crypto/"

LICENSE="CRACKLIB"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"

DEPEND="virtual/glibc sys-apps/miscfiles"

src_unpack() {

 	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/${P}-redhat.patch || die
	patch -p1 <${FILESDIR}/${P}-gentoo-new.diff || die
}

src_compile() {
	# Parallel make does not work for 2.7
	make all || die
}

src_install() {

	dodir /usr/{lib,sbin,include} /usr/share/cracklib

	make DESTDIR=${D} install || die

	# This link is needed and not created. :| bug #9611
	cd ${D}/usr/lib
	dosym libcrack.so.2.7 /usr/lib/libcrack.so.2
	cd ${S}

	preplib /usr/lib

	dodoc HISTORY LICENCE MANIFEST POSTER README
}
