# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.16.17.ebuild,v 1.2 2005/04/15 05:01:11 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Assembler and loader used to create kernel bootsector"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
SRC_URI="http://www.cix.co.uk/~mayday/dev86/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:/man/man1:/share/man/man1:' \
		-e '/^INSTALL_OPTS/s:-s::' \
		Makefile || die "sed"
}

src_compile() {
	emake \
		PREFIX="/usr" \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -D_POSIX_SOURCE" \
		LDFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install PREFIX="${D}/usr" || die "install"
	dodoc README* ChangeLog
}
