# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usermode-utilities/usermode-utilities-20030205.ebuild,v 1.4 2004/01/28 08:56:29 spock Exp $

S=${WORKDIR}/tools
DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="mirror://sourceforge/user-mode-linux/uml_utilities_${PV}.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -ppc ~sparc -alpha"

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE -g -Wall" all
}

src_install () {
	make DESTDIR=${D} install

	dodoc COPYING
}
