# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxracer/tuxracer-0.61-r3.ebuild,v 1.1 2003/09/10 19:29:22 vapier Exp $

inherit games eutils gcc

DESCRIPTION="take on the role of Tux, the Linux Penguin, as he races down steep, snow-covered mountains"
HOMEPAGE="http://tuxracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/tuxracer/${PN}-data-${PV}.tar.gz
	mirror://sourceforge/tuxracer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="stencil-buffer"

DEPEND="virtual/opengl
	virtual/glu
	>=dev-lang/tk-8.0.5-r2
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack ${PN}-data-${PV}.tar.gz

	# braindead check in configure fails - hack approach
	epatch ${FILESDIR}/${PV}-configure.in.patch
	epatch ${FILESDIR}/${PV}-gcc3.patch

	autoconf || die "autoconf failed"
}

src_compile() {
	egamesconf \
		`use_enable stencil-buffer` \
		--with-data-dir=${GAMES_DATADIR}/${PN} \
		|| die
	make || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"

	dodir ${GAMES_DATADIR}/${PN}
	cp -r ${PN}-data-${PV}/* ${D}/${GAMES_DATADIR}/${PN}/

	dodoc README AUTHORS NEWS
	dohtml -r html/*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "If you had the game installed before please reset"
	ewarn "the data_dir variable in ~/.tuxracer/options"
}
