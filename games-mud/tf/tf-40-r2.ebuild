# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-40-r2.ebuild,v 1.2 2004/02/03 01:07:09 mr_bones_ Exp $

MY_P=${P}s1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A small full-featured MUD client"
HOMEPAGE="http://tf.tcp.com/~hawkeye/tf/"
SRC_URI="mirror://tinyfugue/${MY_P}.tar.gz
	doc? mirror://tinyfugue/${MY_P}-help.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die
}
src_compile() {

	dodir /usr/bin /usr/lib/${MY_P}-lib
	dodir /usr/share/man/man1
	echo 'y' | ./unixmake config || die
	./unixmake all || die
}

src_install () {

	dobin src/tf
	newman src/tf.1.catman tf.1
	insinto /usr/lib/${MY_P}-lib
	insopts -m0755
	doins tf-lib/*
	doins CHANGES
	dodoc CHANGES CREDITS README
	use doc && dohtml -r ${WORKDIR}/${MY_P}-help
}
