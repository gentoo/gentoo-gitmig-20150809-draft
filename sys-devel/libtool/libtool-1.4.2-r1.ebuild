# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.2-r1.ebuild,v 1.7 2002/08/14 03:49:37 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

SLOT="0"

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
	patch -p1 <${FILESDIR}/libtool-${PV}-gentoo.patch || die
	automake --gnu --add-missing
	aclocal
	autoconf
	( cd libltdl ; autoheader ; automake --gnu --add-missing ; \
	  aclocal ; autoconf )
}

src_compile() {
	#we do not wat to libtoolize this build.
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

