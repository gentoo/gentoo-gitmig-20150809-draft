# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsmlib/gsmlib-1.10-r1.ebuild,v 1.1 2004/07/24 20:43:42 liquidx Exp $

inherit eutils

DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/download/${P}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND=""

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Missing #include <cassert>
	epatch ${FILESDIR}/${P}-include-fix.patch

	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=168475
	epatch ${FILESDIR}/${P}-fd-leak-fix.patch
}

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
