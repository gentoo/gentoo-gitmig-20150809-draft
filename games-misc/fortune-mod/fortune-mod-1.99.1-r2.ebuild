# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod/fortune-mod-1.99.1-r2.ebuild,v 1.5 2006/07/20 08:08:46 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The notorious fortune program"
HOMEPAGE="http://www.redellipse.net/code/fortune"
SRC_URI="http://www.redellipse.net/code/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="offensive"

DEPEND="app-text/recode"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/01_all_fortune_all-fix.patch

	sed -i \
		-e 's:/games::' \
		-e 's:/fortunes:/fortune:' \
		-e '/^FORTDIR=/s:=.*:=$(prefix)/usr/bin:' \
		-e '/^all:/s:$: fortune/fortune.man:' \
		-e "/^OFFENSIVE=/s:=.*:=`use offensive && echo 1 || echo 0`:" \
		Makefile || die "sed Makefile failed"

	if use elibc_FreeBSD ; then
		sed -i \
			-e '/^REGEXLIBS=/s:=.*:= -lcompat:' \
			Makefile \
			|| die "sed REGEXLIBS failed"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make prefix="${D}" install || die "make install failed"
	dodoc ChangeLog INDEX Notes Offensive README TODO cookie-files
}
