# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mmucl/mmucl-1.5.2-r1.ebuild,v 1.5 2007/04/09 18:41:29 nyhm Exp $

inherit games

DESCRIPTION="Marks MUd CLient - A mud client written completely in tcl/tk"
HOMEPAGE="http://mmucl.sourceforge.net/"
SRC_URI="mirror://sourceforge/mmucl/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="readline mccp gtk"

DEPEND=">=dev-lang/tk-8.4
	readline? ( dev-tcltk/tclreadline )
	mccp? ( dev-tcltk/tcl-mccp )
	gtk? ( dev-tcltk/tcl-gtk )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^BASE_DIR/ s:=.*:=/usr:" \
		-e "/^BIN_DIR/ s:=.*:=${GAMES_BINDIR}:" \
		-e "/^LIB_DIR/ s:=.*:=$(games_get_libdir)/${PN}:" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install () {
	dogamesbin mmucl2 || die "dogamesbin failed"
	insinto "$(games_get_libdir)"/${PN}/lib
	doins lib/*.tcl || die "doins failed (lib)"
	insinto "$(games_get_libdir)"/${PN}/images
	doins images/*.gif || die "doins failed (images)"
	insinto "$(games_get_libdir)"/${PN}/interface
	doins interface/*.tcl || die "doins failed (interface)"
	insinto "$(games_get_libdir)"/${PN}/script
	doins script/*.{tcl,rc} || die "doins failed (script)"
	insinto "$(games_get_libdir)"/${PN}/script/contrib
	doins script/contrib/* || die "doins failed (contrib)"
	insinto "$(games_get_libdir)"/${PN}/test
	doins test/*.test || die "doins failed (test)"
	doinfo mmucl.info
	dodoc CHANGES TODO README
	dohtml mmucl.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "The executable for this is mmucl2."
}
