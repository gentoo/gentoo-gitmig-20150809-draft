# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r6.ebuild,v 1.10 2003/02/20 22:00:24 zwelch Exp $

inherit eutils

IUSE=""

S="${WORKDIR}/cracklib,${PV}"
DESCRIPTION="Cracklib"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/utils/cracklib2_${PV}.orig.tar.gz"
HOMEPAGE="http://www.users.dircon.co.uk/~crypto/"

SLOT="0"
LICENSE="CRACKLIB"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND="sys-apps/miscfiles"

src_unpack() {

 	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-redhat.patch
	epatch ${FILESDIR}/${P}-gentoo-new.diff
}

src_compile() {
	# Parallel make does not work for 2.7
	make all || die
}

src_install() {

	dodir /usr/{lib,sbin,include}
	keepdir /usr/share/cracklib
	
	make DESTDIR=${D} install || die

	# This link is needed and not created. :| bug #9611
	cd ${D}/usr/lib
	dosym libcrack.so.2.7 /usr/lib/libcrack.so.2
	cd ${S}

	cp ${S}/cracklib/packer.h ${D}/usr/include

	preplib /usr/lib

	dodoc HISTORY LICENCE MANIFEST POSTER README
}
