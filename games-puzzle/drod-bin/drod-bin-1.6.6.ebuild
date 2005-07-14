# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/drod-bin/drod-bin-1.6.6.ebuild,v 1.2 2005/07/14 19:59:34 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Deadly Rooms Of Death: face room upon room of deadly things, armed with only your sword and your wits"
HOMEPAGE="http://www.drod.net/"
SRC_URI="mirror://sourceforge/drod/CDROD-${PV}-setup.sh.bin"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_makeself
	GDIR=${GAMES_PREFIX_OPT}/drod
}

src_install() {
	./install.sh -R "${D}" -s "${GDIR}" -al -pn -o -I \
		|| die "install.sh failed"
	dodir "${GAMES_BINDIR}"
	dosym "${GDIR}/drod" "${GAMES_BINDIR}/drod"
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	if [ -d "${ROOT}${GDIR}/bin/Data" ] ; then
		mv "${ROOT}${GDIR}"/{bin/Data,Data.backup}
		echo
		ewarn "Your saved games have been backed up to ${GDIR}/Data.backup."
		ewarn "You can restore your game by copying the files to"
		ewarn "~/.caravel/drod-1_6/ like this:"
		ewarn "    mkdir -p ~/.caravel/drod-1_6/"
		ewarn "    cp ${GDIR}/Data.backup/* ~/.caravel/drod-1_6/"
		echo
	fi
}
