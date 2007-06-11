# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usermode-utilities/usermode-utilities-20060323.ebuild,v 1.1 2007/06/11 16:10:24 dang Exp $

inherit eutils

S=${WORKDIR}/tools-${PV}
DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="http://www.user-mode-linux.org/~blaisorblade/uml-utilities/uml_utilities_${PV}.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-20060216-unlazy.patch
	epatch ${FILESDIR}/${P}-nostrip.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DTUNTAP -D_LARGEFILE64_SOURCE -g -Wall" all
}

src_install () {
	make DESTDIR=${D} install

	dodoc COPYING
}
