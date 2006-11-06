# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/dragonhunt/dragonhunt-3.55.ebuild,v 1.1 2006/11/06 21:33:42 tupone Exp $

inherit games

MY_PN="Dragon_Hunt"

DESCRIPTION="A simple graphical RPG."
HOMEPAGE="http://emhsoft.com/dh.html"
SRC_URI="http://emhsoft.com/dh/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2 CCPL-ShareAlike-1.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygame"

S="${WORKDIR}/${MY_PN}-${PV}"
MODULE_DIR="${GAMES_DATADIR}/${PN}/"
LIB_DIR="${GAMES_LIBDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Where to look for modules to load.
	sed -i -e "s:\.\./modules/:${MODULE_DIR}:" \
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

	# Make the launch scripts look in the right place for the code.
	sed -i \
		-e '/^tempname/d' \
		-e "s:^cd.*:cd ${LIB_DIR}:" \
		Dragon_Hunt_Linux Map_Editor \
		|| die "Could not change launch location."
}

src_install() {
	insinto ${MODULE_DIR}
	doins -r modules/*

	insinto ${GAMES_SYSCONFDIR}/${PN}
	doins settings.txt

	# Install the code for running the game, the compiled python isn't included
	# as I cannot safely change the directory paths in it.
	insinto ${LIB_DIR}
	doins code/*.py

	newgamesbin Dragon_Hunt_Linux ${PN}
	newgamesbin Map_Editor ${PN}-mapeditor

	dodoc README.txt docs/{Changelog,Items.txt,example_map.txt,tiles.txt}
	dohtml docs/*.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "If you use the map editor then note that maps will be saved as"
	einfo "~/dh_map.txt and must be move to the correct module directory"
	einfo "(within ${MODULE_DIR}) by hand."
	echo
}
