# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-40-r1.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

S=${WORKDIR}/${PN}-${PV}s1
DESCRIPTION="A small full-featured MUD client"
SRC_URI="mirror://tinyfugue/${PN}-${PV}s1.tar.gz"
HOMEPAGE="http://tf.tcp.com/~hawkeye/tf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${PN}-${PV}s1.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die
}
src_compile() {

	dodir /usr/bin /usr/lib/tf-${PV}s1-lib
	dodir /usr/share/man/man1
	echo 'y' | ./unixmake config || die
	./unixmake all || die
}

src_install () {

	dodir /usr/lib/tf-${PV}s1-lib
	dobin src/tf
	newman src/tf.1.catman tf.1
	insinto /usr/lib/tf-${PV}s1-lib
	insopts -m0755
	doins tf-lib/*
	doins CHANGES
	dodoc CHANGES COPYING CREDITS README
}
