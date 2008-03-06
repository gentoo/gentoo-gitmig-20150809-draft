# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse/abuse-0.7.1.ebuild,v 1.1 2008/03/06 03:07:09 wolf31o2 Exp $

inherit eutils games

ZOY="http://abuse.zoy.org/attachment/wiki/Downloads/"

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://abuse.zoy.org/"
SRC_URI="${ZOY}/${P}.tar.gz?format=raw
	!demo? ( ${ZOY}/abuse-data-2.00.tar.gz?format=raw )
	demo? ( ${ZOY}/abuse-lib-2.00.tar.gz?format=raw )
	sounds? ( ${ZOY}/abuse-sfx-2.00.tar.gz?format=raw )
	levels? ( ${ZOY}/abuse-frabs-2.11.tar.gz?format=raw )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="demo levels sounds"

RDEPEND=">=media-libs/libsdl-1.1.6"
DEPEND="${RDEPEND}
	x11-libs/libXt
	virtual/opengl"

src_unpack() {
	for a in ${A}
	do
		newname=${a%*?format=raw}
		cp "${DISTDIR}"/${a} "${T}"/${newname}
#		mkdir -p "${T}"/${newname}-unpack
#		cd "${T}"/${newname}-unpack
		unpack ../temp/${newname}
	done
}

src_compile() {
	# Abuse auto-appends games, so point to the base
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	# Sourcce-based install
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	# Data install
	insinto "${GAMES_DATADIR}"/abuse
	for i in addon art levels lisp music netlevel register sfx
	do
		doins -r "${WORKDIR}"/${i} || die "copying ${i}"
	done
	doins "${WORKDIR}"/README.datafiles "${WORKDIR}"/abuse.lsp || die "doins"

	# Icons/desktop entry
	doicon abuse.png
	make_desktop_entry abuse "Abuse" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE: If you had previous version of abuse installed"
	elog "you may need to remove ~/.abuse for the game to work correctly."
}
