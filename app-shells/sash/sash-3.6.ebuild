# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.6.ebuild,v 1.17 2004/06/29 03:58:52 vapier Exp $

inherit eutils

DESCRIPTION="A small static UNIX Shell with readline support"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ~ia64 ppc64"
IUSE="readline"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/sash-3.6-fix-includes.patch
	use readline && epatch ${FILESDIR}/sash-3.6-readline.patch
	use ppc64 && epatch ${FILESDIR}/sash-3.6-ppc64-includes.patch
	use ppc && epatch ${FILESDIR}/sash-3.6-2.6-includes.patch
	sed -e "s:-O3:${CFLAGS}:" -i Makefile
}

src_compile() {
	make || die
}

src_install() {
	into /
	dobin sash
	doman sash.1
	dodoc README
}
