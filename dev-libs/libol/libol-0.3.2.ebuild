# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libol/libol-0.3.2.ebuild,v 1.3 2002/07/11 06:30:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Support library for syslog-ng"
SRC_URI="http://www.balabit.hu/downloads/libol/0.3/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"
SLOT="0"
LICENSE="GPL"

DEPEND="virtual/glibc"

src_compile() {

	econf --enable-shared --enable-static --disable-libtool-lock || die
	emake CFLAGS="${CFLAGS}" all || die
}

src_install() {

	einstall || die
	dodoc ChangeLog 
}
