# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.2-r1.ebuild,v 1.1 2002/03/12 22:44:06 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	#fix the relink problem where the relinked libs do not get
	#installed.
	#NOTE: all affected apps should get a
	#      "libtoolize --automake --copy --force" added to upate
	#      libtool
	patch -p1 <${FILESDIR}/libtool-${PV}-gentoo.patch || die
	automake --gnu --add-missing
	aclocal
	autoconf
	( cd libltdl ; autoheader ; automake --gnu --add-missing ; \
	  aclocal ; autoconf )
}

src_compile() {
	alias __libtoolize="/bin/true"
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info || die
	unalias __libtoolize

	emake || die
}

src_install() { 
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	
}

