# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/fileutils/fileutils-4.0.36-r1.ebuild,v 1.2 2001/02/15 18:17:31 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

src_compile() {
	try ./configure --prefix=/usr --host=${CHOST} --disable-nls
	try make ${MAKEOPTS} LDFLAGS=-static
}

src_install() {

        cd ${S}/src
	into /
        dobin  chgrp chown dd dir du ln mkdir mknod rm touch \
               chmod cp df ls mkfifo mv rmdir sync
        newbin ginstall install
        dosym /bin/install /usr/bin/install
}

