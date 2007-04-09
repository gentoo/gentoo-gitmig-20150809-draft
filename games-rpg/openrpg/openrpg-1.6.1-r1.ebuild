# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/openrpg/openrpg-1.6.1-r1.ebuild,v 1.3 2007/04/09 20:51:48 nyhm Exp $

inherit eutils games

DESCRIPTION="Open RPG Client"
HOMEPAGE="http://www.openrpg.com/"
SRC_URI="mirror://sourceforge/openrpg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="<dev-python/wxpython-2.5
	>=dev-lang/python-2.2.2"

S="${WORKDIR}/${PN}1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	edos2unix *.py
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
	find -name CVS -type d -exec rm -rf '{}' \; 2>/dev/null
	mkdir "${WORKDIR}/docs"
	mv readme.txt "${WORKDIR}/docs"
	rm license.txt
	mkdir "${WORKDIR}/bins"
	mv start.py "${WORKDIR}/bins/openrpg"
	mv start_server.py "${WORKDIR}/bins/openrpg-server"
	mv start_server_gui.py "${WORKDIR}/bins/openrpg-server-gui"
	rm -f start.py start_server.py start_server_gui.py
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_LIBDIR:$(games_get_libdir)/${PN}:" \
		"${WORKDIR}/bins/openrpg" \
		"${WORKDIR}/bins/openrpg-server" \
		"${WORKDIR}/bins/openrpg-server-gui" \
		|| die "sed failed"
	mv orpg/templates . || die "mv failed"
}

src_install() {
	dogamesbin "${WORKDIR}/bins/"*
	dodoc "${WORKDIR}/docs/"*

	insinto "$(games_get_libdir)/${PN}"
	doins *.py || die "doins failed"
	cp -r orpg "${D}/$(games_get_libdir)/${PN}/" || die "cp failed"

	dodir "${GAMES_DATADIR}/${PN}/orpg"
	cp -r templates/ "${D}/${GAMES_DATADIR}/${PN}/orpg/" || die "cp failed"
	cp -r data/ images/ "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	cp *.pyw "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"

	keepdir "${GAMES_DATADIR}/${PN}/myfiles"
	prepgamesdirs
	# i dont like this but the game needs to be rewritten more than
	# i care to do myself to support ${HOME}/.openrpg
	fperms g+w "${GAMES_DATADIR}/${PN}/myfiles"
}
