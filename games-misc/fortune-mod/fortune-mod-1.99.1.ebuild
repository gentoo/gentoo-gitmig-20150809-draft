# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod/fortune-mod-1.99.1.ebuild,v 1.1 2004/05/12 21:29:43 wolf31o2 Exp $

inherit eutils

DESCRIPTION="The notorious fortune program"
HOMEPAGE="http://www.redellipse.net/code/fortune/"
SRC_URI="http://www.redellipse.net/code/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="offensive"

DEPEND="virtual/glibc
	app-text/recode"

[ `use offensive` ] && off=1 || off=0

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:/games::' \
		-e 's:/fortunes:/fortune:' \
		-e 's:FORTDIR=$(prefix)/usr:FORTDIR=$(prefix)/usr/bin:' \
		-e "s:^CFLAGS=.*$:CFLAGS=\$(DEFINES) ${CFLAGS}:" \
		Makefile
	sed -i 's:char a, b;:short int a, b;:' util/rot.c

	# fixes the '-m' segfault problem on _my_ computer, it might screw something else up i don't know about.
	sed -i \
		'/if (fp->utf8_charset)/{
			N
			/free (output);/d
		}' fortune/fortune.c
}

src_compile() {
	emake \
		OFFENSIVE="${off}" \
		|| die
}

src_install() {
	make \
		OFFENSIVE="${off}" \
		prefix="${D}" \
		install \
		|| die

	dodoc ChangeLog INDEX INSTALL Notes Offensive README TODO cookie-files
}
