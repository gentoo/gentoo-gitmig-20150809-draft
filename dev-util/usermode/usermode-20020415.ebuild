# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/usermode/usermode-20020415.ebuild,v 1.5 2002/08/16 04:04:42 murphy Exp $

S=${WORKDIR}/tools
DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="mirror://sourceforge/user-mode-linux/uml_utilities_${PV}.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	emake CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE -g -Wall" all
}

src_install () {

	make DESTDIR=${D} install

	dodoc COPYING 	
}
