# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdspeed/cdspeed-0.3.ebuild,v 1.4 2004/02/29 17:19:59 aliz Exp $

DESCRIPTION="Change the speed of your CD drive."
HOMEPAGE="http://linuxfocus.org/~guido/"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips"

SLOT="0"
SRC_URI="http://linuxfocus.org/~guido/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:^CFLAGS=-O.*:CFLAGS=${CFLAGS}:" \
		Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe cdspeed
	exeinto /usr/lib/cdspeed
	doexe cdmount
	dodoc README
}
