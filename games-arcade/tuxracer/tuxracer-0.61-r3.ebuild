# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxracer/tuxracer-0.61-r3.ebuild,v 1.13 2006/09/18 23:19:05 mr_bones_ Exp $

inherit autotools eutils flag-o-matic games

DESCRIPTION="take on the role of Tux, the Linux Penguin, as he races down steep, snow-covered mountains"
HOMEPAGE="http://tuxracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/tuxracer/${PN}-data-${PV}.tar.gz
	mirror://sourceforge/tuxracer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="stencil-buffer"

DEPEND="virtual/opengl
	virtual/glu
	>=dev-lang/tk-8.0.5-r2
	media-libs/sdl-mixer"

pkg_setup() {
	einfo "This probably isn't the package you want.  You probably want games-arcade/ppracer."
	ebeep
	epause 10
	games_pkg_setup
}
src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	unpack ${PN}-data-${PV}.tar.gz

	# braindead check in configure fails - hack approach
	epatch \
		"${FILESDIR}"/${PV}-configure.in.patch \
		"${FILESDIR}"/${PV}-gcc3.patch

	export WANT_AUTOCONF=2.5
	eautoreconf
}

src_compile() {
	# alpha needs -mieee for this game to avoid FPE
	use alpha && append-flags -mieee

	egamesconf \
		$(use_enable stencil-buffer) \
		--with-data-dir="${GAMES_DATADIR}/${PN}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ${PN}-data-${PV}/* "${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"

	dodoc AUTHORS ChangeLog README
	dohtml -r html/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "If you had the game installed before please reset"
	ewarn "the data_dir variable in ~/.tuxracer/options"
}
