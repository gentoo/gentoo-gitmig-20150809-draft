# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.10-r1.ebuild,v 1.11 2003/06/21 21:19:40 drobbins Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="http://surriel.com/${PN}/${P}.tar.bz2"
HOMEPAGE="http://surriel.com/procps/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa"

RDEPEND=">=sys-libs/ncurses-5.2-r2"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.35"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Use the CFLAGS from /etc/make.conf.
	# remove /etc/X11/applnk/Desktop/top.app from makefile
	mv Makefile Makefile.orig
	sed \
		-e "s:-O3:${CFLAGS}:" \
		-e 's|all: config|all: |' \
	    -e "s:--strip::" \
		-e 's:$.DESKTOP.::' \
		Makefile.orig > Makefile

	# WARNING! In case of a version bump, check the line below that
	# removes a line from the Makefile file.
	cd ${S}/ps
	mv Makefile Makefile.orig
	sed \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:/var/.*man/:${D}var/.*man/:" \
		-e "s:-lproc:-lproc -L${D}lib:" \
	    Makefile.orig > Makefile

	cd ${S}/proc
	mv Makefile Makefile.orig
	sed \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:--strip::" \
		Makefile.orig > Makefile
}

src_compile() { 
	dodir /lib

	make SHLIBDIR="${D}lib" || die
}

src_install() {
	dodir /usr/bin
	dodir /sbin
	dodir /usr/X11R6/bin
	dodir /usr/share/man/man{1,5,8}
	dodir /lib
	dodir /bin

	exeinto /lib
	doexe proc/libproc.so.2.0.10
	dosym /lib/libproc.so.2.0.10 /lib/libproc.so

	einstall DESTDIR="${D}" || die

	dodoc BUGS COPYING COPYING.LIB NEWS TODO
	docinto proc
	dodoc proc/COPYING
	docinto ps
	dodoc ps/COPYING ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: By default \"ps\" and \"top\" no longer"
	einfo "show threads. You can use the '-m' flag"
	einfo "in ps or the 'H' key in top to show them"
}
