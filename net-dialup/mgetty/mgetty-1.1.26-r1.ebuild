# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}
DESCRIPTION="Fax and Voice modem programs."

SRC_URI="ftp://alpha.greenie.net/pub/mgetty/source/1.1/${PN}${PV}-Apr16.tar.gz"
HOMEPAGE="http://alpha.greenie.net/mgetty"

DEPEND="sys-libs/glibc
	app-text/tetex
	sys-apps/gawk
	sys-devel/perl"

src_compile() {
	cd doc
	patch -p0 < ${FILESDIR}/mgetty-${PV}-gentoo.diff
	cd ..
	sed -e 's/var\/log\/mgetty/var\/log\/mgetty\/mgetty/' policy.h-dist > policy.h
	emake || die
	cd voice
	emake || die
	cd ..
}

src_install () {
	#you must *personally verify* that this trick doesn't install
	#anything outside of DESTDIR; do this by reading and understanding
	#the install part of the Makefiles.  Also note that this will often
	#also work for autoconf stuff (usually much more often than DESTDIR,
	#which is actually quite rare.
	
	dodir /var/spool
	dodir /usr/share/info
	make prefix=${D}/usr INFODIR=${D}/usr/share CONFDIR=${D}/etc/mgetty+sendfax spool=${D}/var/spool install || die
	cd voice
	make prefix=${D}/usr spool=${D}/var/spool install || die

    	#make DESTDIR=${D} install || die
	#again, verify the Makefiles!  We don't want anything falling outside
	#of ${D}.
}

