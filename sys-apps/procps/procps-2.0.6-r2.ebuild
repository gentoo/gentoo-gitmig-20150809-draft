# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.6-r2.ebuild,v 1.2 2001/12/30 01:16:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="ftp://people.redhat.com/johnsonm/procps/${P}.tar.gz"
DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}.diff
	mv Makefile Makefile.orig
	sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' \
	-e "s:--strip::" -e 's:/usr/man:/usr/share/man:' Makefile.orig > Makefile
	cd ${S}/ps
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" -e 's:/usr/man:/usr/share/man:' Makefile.orig > Makefile
	cd ${S}/proc
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" -e 's:/usr/man:/usr/share/man:' Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /sbin
	dodir /usr/X11R6/bin
	dodir /usr/share/man/man{1,5,8}
	dodir /lib
	dodir /bin
	make DESTDIR=${D} install || die
	preplib /
	dodoc BUGS COPYING COPYING.LIB NEWS TODO
	docinto proc
	dodoc proc/COPYING
	docinto ps
	dodoc ps/COPYING ps/HACKING
}
