# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Submitted by: Ferdy <ferdy@ferdyx.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/geekcode/geekcode-1.7.ebuild,v 1.1 2003/06/05 13:35:04 brad Exp $

DESCRIPTION="Geek code generator"

HOMEPAGE="http://geekcode.sourceforge.net/"

SRC_URI="mirror://sourceforge/geekcode/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"

#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin
	dobin geekcode

	dodoc CHANGES COPYING INSTALL README geekcode.txt
}
