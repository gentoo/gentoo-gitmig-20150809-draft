# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod/fortune-mod-1.99.1.ebuild,v 1.11 2004/09/16 15:08:52 gustavoz Exp $

inherit eutils

DESCRIPTION="The notorious fortune program"
HOMEPAGE="http://www.redellipse.net/code/fortune"
SRC_URI="http://www.redellipse.net/code/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc ~mips amd64 hppa"
IUSE="offensive"

DEPEND="virtual/libc
	app-text/recode"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:/games::' \
		-e 's:/fortunes:/fortune:' \
		-e 's:FORTDIR=$(prefix)/usr:FORTDIR=$(prefix)/usr/bin:' \
		-e 's:^CFLAGS=.*$:CFLAGS=$(DEFINES) $(E_CFLAGS):' \
		-e '/^all:/s:$: fortune/fortune.man:' \
		Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e 's:char a, b;:short int a, b;:' util/rot.c \
		|| die "sed util/rot.c failed"

	# fixes the '-m' segfault problem on _my_ computer,
	# it might screw something else up i don't know about.
	sed -i \
		-e '/if (fp->utf8_charset)/{
			N
			/free (output);/d
		}' fortune/fortune.c \
		|| die "sed fortune/fortune.c failed"
	use offensive && off=1 || off=0
}

src_compile() {
	emake \
		E_CFLAGS="${CFLAGS}" \
		OFFENSIVE="${off}" \
		|| die "emake failed"
}

src_install() {
	make \
		OFFENSIVE="${off}" \
		prefix="${D}" \
		install \
		|| die "make install failed"

	dodoc ChangeLog INDEX INSTALL Notes Offensive README TODO cookie-files
}
