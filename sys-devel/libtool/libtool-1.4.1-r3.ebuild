# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.1-r3.ebuild,v 1.1 2002/03/21 05:11:34 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Fix the relink problem where the relinked libs do not get
	# installed.  It is *VERY* important that you get a updated
	# 'libtool-${PV}-relink.patch' if you update this, as it
	# fixes a very serious bug.  Please not that this patch is
	# included in 'libtool-${PV}-gentoo.patch' for this ebuild.
	#
	# NOTE: all affected apps should get a 'libtoolize --copy --force'
	#      added to upate libtool
	#

	cd ${S}
	patch -p1 <${FILESDIR}/${PV}/${P}-nonneg.patch || die
	patch -p0 <${FILESDIR}/${PV}/${P}-relink.patch || die
	#fixes quoting for test's .. *VERY* important!
	patch -p0 <${FILESDIR}/${PV}/${P}-test.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-duplicate-dependency.patch || die
}

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info || die

	emake || die
}

src_install() { 
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	

	cd ${D}/usr/share/libtool
	patch -p0 < ${FILESDIR}/${PV}/${P}-ltmain.sh-hack.patch || die
}

