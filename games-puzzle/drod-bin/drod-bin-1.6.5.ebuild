# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/drod-bin/drod-bin-1.6.5.ebuild,v 1.6 2004/09/23 09:54:51 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Deadly Rooms Of Death: face room upon room of deadly things, armed with only your sword and your wits"
HOMEPAGE="http://www.drod.net/"
SRC_URI="mirror://sourceforge/drod/CDROD-${PV}-setup.sh.bin"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/x11
	dev-libs/expat
	media-libs/fmod
	media-libs/libsdl
	>=media-libs/sdl-ttf-2.0.6"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself ${A}
	cd "${S}"
	epatch "${FILESDIR}/install.patch"
}

src_install() {
	./install.sh -R "${D}" -g -rl -pg -I || die "install.sh failed"
	dodir "${GAMES_BINDIR}"
	dosym /opt/drod/bin/drod "${GAMES_BINDIR}/drod"
	prepgamesdirs
	fperms 770 /opt/drod/bin/Data
}

pkg_preinst() {
	if [ -d ${ROOT}/opt/drod/bin/Data ] ; then
		mv ${ROOT}/opt/drod/bin/Data{,.backup} || die "failed to backup data"
	fi
}

pkg_postinst() {
	games_pkg_postinst
	if [ -d ${ROOT}/opt/drod/bin/Data.backup ] ; then
		ewarn "Your saved games have been backed up to"
		ewarn "/opt/drod/bin/Data.backup"
	fi
}
