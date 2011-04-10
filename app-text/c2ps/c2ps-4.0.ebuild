# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/c2ps/c2ps-4.0.ebuild,v 1.17 2011/04/10 03:15:29 abcd Exp $

EAPI=3
inherit toolchain-funcs

DESCRIPTION="Generates a beautified ps document from a source file (c/c++)"
HOMEPAGE="http://www.cs.technion.ac.il/users/c2ps"
SRC_URI="http://www.cs.technion.ac.il/users/c2ps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CCFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake MAN="${ED}"/usr/share/man/man1 PREFIX="${ED}"/usr install || die
	dodoc README
}
