# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/schedutils/schedutils-1.1.0.ebuild,v 1.4 2003/04/12 14:54:23 lostlogic Exp $

DESCRIPTION="Utilities for manipulating kernel schedular parameters"
HOMEPAGE="http://tech9.net/rml/schedutils"
KEYWORDS="~x86 -ppc"
LICENSE="GPL-2"

RDEPEND="virtual/glibc"
DEPEND="$RDEPEND"
SLOT="0"

SRC_URI="http://tech9.net/rml/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -ie 's:\(#include <features.h>\):\1\n#include <errno.h>:' taskset.c
}

src_compile() {
	emake PREFIX=/usr || die "Make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/doc
	einstall PREFIX=${D}/usr || die "Install failed"
}
