# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1-r6.ebuild,v 1.2 2001/10/06 17:04:49 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/findutils/${P}.tar.gz ftp://prep.ai.mit.edu/gnu/findutils/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"
DEPEND="virtual/glibc sys-devel/gettext"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	echo "Applying Patch..."
	#using sed to apply minor patches to files
	cd ${S}
	cd find
	cp fstype.c fstype.c.orig
	sed -e "33d" -e "34d" fstype.c.orig > fstype.c
	cp parser.c parser.c.orig
	sed -e "55d" parser.c.orig > parser.c
	cp pred.c pred.c.orig
	sed -e '29i\' -e '#define FNM_CASEFOLD (1<<4)' pred.c.orig > pred.c
	cd ${S}/lib
	cp nextelem.c nextelem.c.orig
	sed -e "35d" nextelem.c.orig > nextelem.c
	cd ${S}/xargs
	cp xargs.c xargs.c.orig
	sed -e "63d" -e "64d" xargs.c.orig > xargs.c
}

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake LOCATE_DB=/var/lib/misc/locatedb libexecdir=/usr/lib/find || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info libexecdir=${D}/usr/lib/find LOCATE_DB=${D}/var/lib/misc/locatedb install || die
	dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
	rm -rf ${D}/usr/var
	if [ -z "`use build`" ] 
	then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}

