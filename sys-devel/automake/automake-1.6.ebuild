# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.6.ebuild,v 1.1 2002/03/21 13:16:23 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://ftp.gnu.org/gnu/automake/${P}.tar.gz"
#	ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"

DEPEND="sys-devel/perl
	>=sys-devel/autoconf-2.53"


src_compile() {
	# stupid configure script goes and run autoconf in a subdir,
	# so 'ac-wrapper.pl' do not detect that it should use autoconf-2.5x
	export WANT_AUTOCONF_2_5=1

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} || die
		
	make ${MAKEOPTS} || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}

