# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-40-r2.ebuild,v 1.4 2004/03/23 16:53:30 augustus Exp $

inherit eutils

MY_P=${P}s1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A small full-featured MUD client"
HOMEPAGE="http://tf.tcp.com/~hawkeye/tf/"
SRC_URI="mirror://tinyfugue/${MY_P}.tar.gz
	doc? ( mirror://tinyfugue/${MY_P}-help.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}
src_compile() {
	dodir /usr/bin /usr/lib/${MY_P}-lib
	dodir /usr/share/man/man1
	echo 'y' | ./unixmake config || die
	./unixmake all || die
}

src_install() {
	dobin src/tf || die
	newman src/tf.1.catman tf.1
	exeinto /usr/lib/${MY_P}-lib
	doexe tf-lib/*
	insinto /usr/lib/${MY_P}-lib
	doins CHANGES
	dodoc CHANGES CREDITS README
	use doc && dohtml -r ${WORKDIR}/${MY_P}-help
}
