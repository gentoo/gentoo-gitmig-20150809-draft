# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.1.3.ebuild,v 1.1 2002/03/23 17:48:22 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.engelschall.com/sw/mm/"
SRC_URI="http://www.engelschall.com/sw/mm/${P}.tar.gz"
DEPEND="virtual/glibc"

src_compile() {
	econf --host=${CHOST} || die "bad ./configure"
	make || die "compile problem"
	make test || die "testing problem"
}

src_install() {
	einstall || die
	dodoc README LICENSE ChangeLog INSTALL PORTING THANKS
}
