# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.5.1.ebuild,v 1.1 2001/10/19 21:48:35 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"

#build-time dependencies
DEPEND=">=kde-base/kdebase-2.0"

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	#you must *personally verify* that this trick doesn't install
	#anything outside of DESTDIR; do this by reading and understanding
	#the install part of the Makefiles.  Also note that this will often
	#also work for autoconf stuff (usually much more often than DESTDIR,
	#which is actually quite rare.
	
	make prefix=${D}/usr install || die

    make DESTDIR=${D} install || die
	#again, verify the Makefiles!  We don't want anything falling outside
	#of ${D}.
}

