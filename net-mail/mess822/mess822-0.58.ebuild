# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mess822/mess822-0.58.ebuild,v 1.1 2003/05/19 15:20:50 agenkin Exp $

DESCRIPTION="Collection of utilities for parsing Internet mail messages."
SRC_URI="http://cr.yp.to/mess822/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/mess822.html"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr/" > conf-home
}

src_compile() {
	make || die
}

src_install() {
	dodir /etc
	dodir /usr/share

	# Now that the commands are compiled, update the conf-home file to point
	# to the installation image directory.
	echo "${D}/usr/" > conf-home
	sed -i "s:c(\"/etc\":c(\"${D}/etc\":" hier.c || die
	
	make setup

	# Move the man pages into /usr/share/man
	mv "${D}/usr/man" "${D}/usr/share/"
	
	dodoc BLURB CHANGES INSTALL README THANKS TODO VERSION
}
