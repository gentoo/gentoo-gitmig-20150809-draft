# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libol/libol-0.3.9.ebuild,v 1.1 2003/02/09 08:04:56 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Support library for syslog-ng"
SRC_URI="http://www.balabit.hu/downloads/libol/0.3/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

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
