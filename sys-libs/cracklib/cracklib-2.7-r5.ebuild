# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r5.ebuild,v 1.6 2002/07/11 06:30:56 drobbins Exp $

S=${WORKDIR}/cracklib,${PV}
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/cracklib2_${PV}.orig.tar.gz"
DEPEND="virtual/glibc sys-apps/miscfiles"
LICENSE="CRACKLIB"
KEYWORDS="x86"
SLOT="0"
HOMEPAGE="http://www.users.dircon.co.uk/~crypto/"

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

	preplib /usr/lib

	dodoc HISTORY LICENCE MANIFEST POSTER README
}
