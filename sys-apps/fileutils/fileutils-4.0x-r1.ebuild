# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.0x-r1.ebuild,v 1.1 2000/08/02 17:07:12 achim Exp $

P=fileutils-4.0x
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
CATEGORY="sys-apps"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/fileutils-4.0x.tar.gz"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

src_compile() {  
	./configure --prefix=/usr
	make
}

src_install() {                               
	dodoc COPYING NEWS README THANKS TODO ChangeLog ChangeLog-1997 AUTHORS
	into /
	cd ${S}/src
	cp ginstall install
	dobin chgrp chmod chown cp dd df dir dircolors du install install ln ls mkdir mkfifo mknod mv rm rmdir shred sync touch vdir
	cd ${S}
	into /usr
	doman man/*.1
	doinfo doc/fileutils.info
	dodir /usr/share/locale
	MOPREFIX=fileutils
	domo po/*.po

}

