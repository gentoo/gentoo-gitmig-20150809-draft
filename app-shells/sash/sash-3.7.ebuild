# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.7.ebuild,v 1.1 2004/02/14 22:23:05 plasmaroo Exp $

inherit eutils

DESCRIPTION="A small static UNIX Shell with readline support"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
IUSE="readline"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.4
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/sash-3.6-fix-includes.patch
	[ `use readline` ] && epatch ${FILESDIR}/sash-3.6-readline.patch
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
