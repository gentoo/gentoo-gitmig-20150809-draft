# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.9.ebuild,v 1.2 2002/10/04 06:29:23 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="http://surriel.com/${PN}/${P}.tar.bz2"
HOMEPAGE="http://surriel.com/procps/"
RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND} >=sys-devel/gettext-0.10.35"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Use the CFLAGS from /etc/make.conf.

	mv Makefile Makefile.orig
	sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' \
	    -e "s:--strip::" Makefile.orig > Makefile

	# WARNING! In case of a version bump, check the line below that removes a line from the Makefile file.
	cd ${S}/ps
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" -e "s:/var/.*man/:${D}var/.*man/:" -e "s:-lproc:-lproc -L${D}lib:" \
	    Makefile.orig > Makefile

	cd ${S}/proc
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" Makefile.orig > Makefile

	#remove /etc/X11/applnk/Desktop/top.app from makefile
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's/$.DESKTOP.//' Makefile.orig > Makefile

}

src_compile() { 
	dodir /lib

	emake SHLIBDIR="${D}lib" || die
}

src_install() {
	dodir /usr/bin
	dodir /sbin
	dodir /usr/X11R6/bin
	dodir /usr/share/man/man{1,5,8}
	dodir /lib
	dodir /bin

	exeinto /lib
	doexe proc/libproc.so.2.0.8
	dosym /lib/libproc.so.2.0.8 /lib/libproc.so

	einstall DESTDIR="${D}" || die

	dodoc BUGS COPYING COPYING.LIB NEWS TODO
	docinto proc
	dodoc proc/COPYING
	docinto ps
	dodoc ps/COPYING ps/HACKING
}

