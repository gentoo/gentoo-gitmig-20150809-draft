# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/c2ps/c2ps-4.0.ebuild,v 1.16 2008/06/08 09:41:31 bluebird Exp $

inherit toolchain-funcs

DESCRIPTION="Generates a beautified ps document from a source file (c/c++)"
HOMEPAGE="http://www.cs.technion.ac.il/users/c2ps"
SRC_URI="http://www.cs.technion.ac.il/users/c2ps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CCFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake MAN="${D}"/usr/share/man/man1 PREFIX="${D}"/usr install || die
	dodoc README
}
