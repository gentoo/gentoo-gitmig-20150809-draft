# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usermode-utilities/usermode-utilities-20040406-r1.ebuild,v 1.1 2005/04/13 15:07:40 johnm Exp $

inherit eutils

S=${WORKDIR}/tools
DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="mirror://sourceforge/user-mode-linux/uml_utilities_${PV}.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -ppc -sparc -alpha"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-CAN-2004-1295.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DTUNTAP -D_LARGEFILE64_SOURCE -g -Wall" all
}

src_install () {
	make DESTDIR=${D} install

	dodoc COPYING
}
