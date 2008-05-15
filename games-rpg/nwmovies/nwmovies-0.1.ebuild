# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwmovies/nwmovies-0.1.ebuild,v 1.3 2008/05/15 13:34:01 nyhm Exp $

inherit eutils games

DESCRIPTION="Play Neverwinter Nights movies inside the Linux client."
HOMEPAGE="http://home.woh.rr.com/nwmovies/nwmovies/"
SRC_URI="http://dev.gentoo.org/~calchan/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=games-rpg/nwn-data-1.29-r3"
RDEPEND="${DEPEND}
	>=games-rpg/nwn-1.68-r4
	media-video/binkplayer"

S="${WORKDIR}"
DESTDIR="${GAMES_PREFIX_OPT}/nwn"

pkg_setup() {
	games_pkg_setup
	built_with_use games-rpg/nwn-data videos || die "nwn-data requires USE=videos"
}

src_install() {
	exeinto "${DESTDIR}"
	doexe nwmovies.so nwmovies.pl || die "Installation failed"
	exeinto "${DESTDIR}/nwmovies"
	doexe nwmovies/binklib.so || die "Installation failed"
	exeinto "${DESTDIR}/nwmovies/libdis"
	doexe nwmovies/libdis/libdisasm.so || die "Installation failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "When starting nwn the next time, nwmovies will scan the nwmain"
	elog "binary for its hooks, store this information in:"
	elog "  \${HOME}/.nwn/\${LANG}/nwmovies.ini"
	elog "and exit. This is normal."
	elog
	elog "You will have to remove this file whenever you update nwn."
	elog
	elog "If you have sound issues in NWN only when using nwmovies, then"
	elog "you'll need to properly setup /etc/asound.conf or the equivalent"
	elog "per-user \${HOME}/.asound.conf, see comment #31 in bug #106789."
}
