# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jwhois/jwhois-3.2.0.ebuild,v 1.3 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Internet Whois client capable of recursive queries"
HOMEPAGE="http://http://www.gnu.org/software/jwhois/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SRC_URI="http://www.mirror.ac.uk/sites/ftp.gnu.org/gnu/jwhois/${P}.tar.gz
         ftp://ftp.gnu.org/gnu/jwhois/${P}.tar.gz"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/cache/ \
		--without-cache \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}

