# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Submitted by: Ferdy <ferdy@ferdyx.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/geekcode/geekcode-1.7.3.ebuild,v 1.6 2004/06/24 22:12:33 agriffis Exp $

DESCRIPTION="Geek code generator"
HOMEPAGE="http://geekcode.sourceforge.net/"
SRC_URI="mirror://sourceforge/geekcode/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc"
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
