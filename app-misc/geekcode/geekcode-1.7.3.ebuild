# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Submitted by: Ferdy <ferdy@ferdyx.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/geekcode/geekcode-1.7.3.ebuild,v 1.4 2004/04/06 23:09:49 weeve Exp $

DESCRIPTION="Geek code generator"
HOMEPAGE="http://geekcode.sourceforge.net/"
SRC_URI="mirror://sourceforge/geekcode/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/bin
	dobin geekcode

	dodoc CHANGES README geekcode.txt
}
