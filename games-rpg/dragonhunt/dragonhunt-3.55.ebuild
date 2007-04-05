# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/dragonhunt/dragonhunt-3.55.ebuild,v 1.2 2007/04/05 01:46:12 nyhm Exp $

inherit games

MY_P="Dragon_Hunt-${PV}"
DESCRIPTION="A simple graphical RPG."
HOMEPAGE="http://emhsoft.com/dh.html"
SRC_URI="http://emhsoft.com/dh/${MY_P}.tar.gz"

LICENSE="GPL-2 CCPL-ShareAlike-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygame"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Where to look for modules to load.
	sed -i -e "s:\.\./modules/:${GAMES_DATADIR}/${PN}/:" \
		code/g.py \
		code/map_editor.py \
		code/rpg.py \
		|| die "Could not change module path."

	# Where to look for keybinding
	sed -i -e "s:\.\./settings:${GAMES_SYSCONFDIR}/${PN}/settings:" \
		code/g.py \
		|| die "Could not change settings.txt directory"

	# Save games in ~/.${PN}/.
	sed -i \
		-e "s:^\(from os import.*\):\1\, environ:" \
		-e "s:g.mod_dir.*\"/saves/\?\":environ[\"HOME\"] + \"/.${PN}/\":" \
		code/g.py code/loadgame.py \
		|| die "Could not change savegames location."

	# Save maps in ~/.
	sed -i \
		-e "s:^\(from os import.*\):\1\, environ:" \
		-e "s:g.mod_dir.*\"map\.txt\":environ[\"HOME\"]\ +\ \"/dh_map.txt\":" \
		code/map_editor.py \
		|| die "Could not change map location."
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r modules/* || die "doins modules failed"

	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins settings.txt || die "doins settings.txt failed"

	insinto "$(games_get_libdir)"/${PN}
	doins code/*.py || die "doins code failed"

	games_make_wrapper ${PN} "python ./rpg.py" "$(games_get_libdir)"/${PN}
	games_make_wrapper ${PN}-mapeditor "python ./map_editor.py" "$(games_get_libdir)"/${PN}

	dodoc README.txt docs/{Changelog,Items.txt,example_map.txt,tiles.txt}
	dohtml docs/*.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "If you use the map editor then note that maps will be saved as"
	elog "~/dh_map.txt and must be move to the correct module directory"
	elog "(within ${GAMES_DATADIR}/${PN}) by hand."
	echo
}
