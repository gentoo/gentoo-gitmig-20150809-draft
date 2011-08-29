# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.7-r2.ebuild,v 1.2 2011/08/29 06:26:39 flameeyes Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A small static UNIX Shell with readline support"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="readline static"

DEPEND=">=sys-libs/zlib-1.2.3
	readline? (
		>=sys-libs/readline-4.1
		sys-libs/ncurses
		static? (
			|| ( <sys-libs/ncurses-5.7-r4 >=sys-libs/ncurses-5.7-r4[static-libs] )
		)
	)"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/sash-3.6-fix-includes.patch
	epatch "${FILESDIR}"/sash-3.7-builtin.patch
	use readline && epatch "${FILESDIR}"/sash-3.6-readline.patch

	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		Makefile || die "sed failed"
}

src_compile() {
	use static && append-ldflags -static

	emake LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	into /
	dobin sash
	doman sash.1
	dodoc README
}
