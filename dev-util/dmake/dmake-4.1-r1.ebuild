# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.1-r1.ebuild,v 1.4 2002/08/16 04:04:41 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Improved make"
SRC_URI="http://plg.uwaterloo.ca/~ftp/dmake/dmake-v4.1-src-export.all-unknown-all.tar.gz"
HOMEPAGE="http://www.scri.fsu.edu/~dwyer/dmake.html"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="x86 sparc sparc64"

DEPEND="sys-apps/groff"

src_unpack() {

	cd ${WORKDIR}
	unpack dmake-v4.1-src-export.all-unknown-all.tar.gz
	
	mv dmake ${P}

	cd ${S}
	cp unix/runargv.c unix/runargv.c.orig
	
	cat unix/runargv.c.orig | \
		sed -e "s:extern.*char \*sys_errlist\[\];::" \
			> unix/runargv.c

	cp unix/startup.h unix/startup.h.orig
	
	cat unix/startup.h | \
		sed -e "s:usr/local/lib/dmake:usr/share/dmake:" \
			> unix/startup.h	
}

src_compile() {

	sh unix/linux/gnu/make.sh
	cp man/dmake.tf man/dmake.1
	
}

src_install () {

	into /usr
	
	doman man/dmake.1
	dobin dmake
	
	insinto /usr/share/dmake/startup
	doins startup/{startup.mk,config.mk} startup/unix

}
