# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.7-r1.ebuild,v 1.3 2011/02/06 22:02:34 leio Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A small static UNIX Shell with readline support"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="readline"

DEPEND=">=sys-libs/zlib-1.2.3
	readline? (
		>=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2
	)"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/sash-3.6-fix-includes.patch
	epatch "${FILESDIR}"/sash-3.7-builtin.patch
	use readline && epatch "${FILESDIR}"/sash-3.6-readline.patch

	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		-e "/^LDFLAGS /s: -s$: ${LDFLAGS}:" \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	into /
	dobin sash || die
	doman sash.1
	dodoc README
}
