# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cpl-stratego/cpl-stratego-0.4.ebuild,v 1.6 2002/12/09 04:21:02 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Choice library mostly used by Stratego"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.stratego-language.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README*
}
