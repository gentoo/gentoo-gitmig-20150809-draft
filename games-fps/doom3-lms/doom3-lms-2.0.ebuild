# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-lms/doom3-lms-2.0.ebuild,v 1.2 2006/03/20 00:03:26 halcy0n Exp $

inherit games

DESCRIPTION="add coop support and/or play against swarms of unending monsters"
HOMEPAGE="http://lms.d3files.com/"
SRC_URI="lms_2_multiplatform.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="nofetch"

RDEPEND="games-fps/doom3"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please visit this website:"
	einfo "http://lms.d3files.com/downloads.php"
	einfo "And download ${A} into ${DISTDIR}"
}

src_install() {
	insinto "${GAMES_PREFIX_OPT}"/doom3
	doins -r lms2 || die "doins lms2"
	prepgamesdirs
}
