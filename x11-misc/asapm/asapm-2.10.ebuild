# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/asapm/asapm-2.10.ebuild,v 1.8 2002/10/04 06:41:20 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="APM monitor for AfterStep"

SRC_URI="http://www.tigr.net/afterstep/download/asapm/asapm-2.10.tar.gz"

HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc virtual/x11"

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff    
	emake || die
}

src_install () {

	dodir usr/bin
	dodir usr/share/man/man1
	
	make prefix=${D} install || die
}

