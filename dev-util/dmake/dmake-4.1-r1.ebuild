# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.1-r1.ebuild,v 1.1 2001/10/07 20:35:07 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Improved make"

SRC_URI="http://plg.uwaterloo.ca/~ftp/dmake/dmake-v4.1-src-export.all-unknown-all.tar.gz"

HOMEPAGE=""

DEPEND="virtual/glibc
        sys-apps/groff"

src_unpack() {

	cd ${WORKDIR}
	unpack dmake-v4.1-src-export.all-unknown-all.tar.gz
	
	mv dmake ${P}
	cp ${S}/unix/runargv.c ${S}/unix/runargv.c.orig
	
	cat ${S}/unix/runargv.c.orig | \
	sed -e "s:extern.*char \*sys_errlist\[\];::" \
	> ${S}/unix/runargv.c

	cp ${S}/unix/startup.h ${S}/unix/startup.h.orig
	
	
	cat ${S}/unix/startup.h | \
	sed -e "s:usr/local/lib/dmake:usr/share/dmake:" \
	> ${S}/unix/startup.h	
}

src_compile() {

	sh unix/linux/gnu/make.sh
	
	cat man/dmake.tf > man/dmake.1
	
}

src_install () {

	into /usr
	
	doman man/dmake.1
	dobin dmake
	
	insinto /usr/share/dmake/startup
	doins startup/{startup.mk,config.mk} startup/unix

}

