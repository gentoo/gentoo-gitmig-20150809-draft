# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libol/libol-0.3.3.ebuild,v 1.1 2002/08/18 02:10:07 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Support library for syslog-ng"
SRC_URI="http://www.balabit.hu/downloads/libol/0.3/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf \
		--enable-shared \
		--enable-static \
		--disable-libtool-lock || die
	emake CFLAGS="${CFLAGS}" all || die
}

src_install() {
	einstall || die
	dodoc ChangeLog 
}
