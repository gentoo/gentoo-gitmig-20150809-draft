# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkfep/skkfep-0.86c.ebuild,v 1.2 2004/06/21 17:22:24 usata Exp $

inherit eutils

IUSE=""

MY_P=${P/-/}
KH_PV="kh1.2.10"

DESCRIPTION="A SKK-like Japanese input method for console"
SRC_URI="http://www1.interq.or.jp/~deton/jvim-skk/${MY_P}.tar.gz
	http://www1.interq.or.jp/~deton/jvim-skk/${MY_P}-${KH_PV}.patch.gz"
HOMEPAGE="http://homepage2.nifty.com/aito/soft.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha"

DEPEND=">=sys-apps/sed-4
	sys-apps/gawk
	sys-libs/ncurses"
RDEPEND="virtual/skkserv"

S=${WORKDIR}/${PN}

src_unpack() {

	unpack ${A}
	epatch ${MY_P}-${KH_PV}.patch
}

src_compile() {

	sed -i -e 's/solaris2/linux/' \
		-e '/^#define USE_SKKSRCH/s/^/\/* /' \
		-e  '/^#define BOTH_SERVER_AND_SKKSRCH/s/^/\/* /' \
		-e '/SUSPEND_FEP/s/^\/\*//' config.h
	sed -i  -e 's/termcap/curses/' \
		-e '/skksrch/s/skksrch\.[co]//' protoMakefile
	make || die "make failed."
}

src_install () {

	exeinto /usr/bin
	doexe skkfep
	doman skkfep.1

	dodoc README* HISTORY INSTALL TODO
}
