# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r3.ebuild,v 1.7 2002/08/01 11:59:04 seemant Exp $

S=${WORKDIR}/cracklib,${PV}
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/cracklib2_${PV}.orig.tar.gz"
LICENSE="CRACKLIB"
KEYWORDS="x86 -ppc"
SLOT="0"
HOMEPAGE="http://www.users.dircon.co.uk/~crypto/"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
  
	cd ${S}
	patch -p1 <${FILESDIR}/${P}-redhat.patch || die
	patch -p1 <${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {

	# Parallel make does not work for 2.7
	make all
}

src_install() {

	dodir /usr/{lib,sbin,include} /usr/share/cracklib

	make DESTDIR=${D} install || die

	mv ${D}/usr/lib ${D}
	preplib /

	insinto /usr/lib
	doins ${FILESDIR}/dict/cracklib_dict.*

	dodoc HISTORY LICENCE MANIFEST POSTER README
}

