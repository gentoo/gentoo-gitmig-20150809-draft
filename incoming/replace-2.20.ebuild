# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Edwards <david.edwards@alhsystems.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.10 2001/11/03 17:27:49 agriffis Exp

S=${WORKDIR}/${P}

DESCRIPTION="The sane person's alternative to sed"

SRC_URI="ftp://hpux.connect.org.uk/hpux/Users/replace-${PV}/replace-${PV}-ss-11.00.tar.gz"

HOMEPAGE="http://replace.richardlloyd.org.uk/"

DEPEND="virtual/glibc"

src_compile() {
#	emake CC=gcc CFLAGS="-O2 -Wall -ansi -D_BSD_SOURCE" LINTFLAGS="" || die
	emake CC=gcc CFLAGS="${CFLAGS} -Wall -ansi -D_BSD_SOURCE" LINTFLAGS="" || die
}

src_install () {
	make TREE=${D}/usr install || die
}
