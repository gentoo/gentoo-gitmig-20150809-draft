# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author First Last <flast@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.3.ebuild,v 1.1 2002/01/30 19:03:57 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lists directories recursively, and produces an indented listing of files."

SRC_URI="ftp://mama.indstate.edu/linux/tree/tree-1.3.tgz"
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"

DEPEND="virtual/glibc"

src_compile() {

	emake || die
}

src_install () {

	make BINDIR=${D}/usr/bin MANDIR=${D}/usr/man/man1 install || die

}



