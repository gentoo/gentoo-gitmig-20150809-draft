# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mess822/mess822-0.58-r1.ebuild,v 1.3 2004/04/15 16:11:10 kugelfang Exp $

DESCRIPTION="Collection of utilities for parsing Internet mail messages."
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/mess822.html"

SLOT="0"
KEYWORDS="x86 ~amd64"
LICENSE="as-is"

DEPEND="virtual/glibc
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr/" > conf-home

	# fix errno.h problem; bug #26165
	sed -i 's/^extern int errno;/#include <errno.h>/' error.h
}

src_compile() {
	emake || die
}

src_install() {
	dodir /etc
	dodir /usr/share

	# Now that the commands are compiled, update the conf-home file to point
	# to the installation image directory.
	echo "${D}/usr/" > conf-home
	sed -i -e "s:\"/etc\":\"${D}/etc\":" hier.c || die "sed hier.c failed"

	make setup

	# Move the man pages into /usr/share/man
	mv "${D}/usr/man" "${D}/usr/share/"

	dodoc BLURB CHANGES INSTALL README THANKS TODO VERSION
}
