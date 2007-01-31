# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-2.0.ebuild,v 1.1 2007/01/31 21:01:31 wolf31o2 Exp $


inherit eutils games

DESCRIPTION="The Community Expansion Pack is a high quality custom content addon for Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/players/cep.html"
SRC_URI="cepv2_Part_A.zip cepv2_Part_B.zip"

LICENSE="as-is"
SLOT="2"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-arch/unzip"
RDEPEND=">=games-rpg/nwn-1.68"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/nwn
Ddir=${D}/${dir}

pkg_nofetch() {
	einfo "Please visit http://nwvault.ign.com/cep/downloads/"
	einfo "and download the .zip versions of ${A}."
	einfo "Then move the files you downloaded to:"
	einfo "${DISTDIR}"
}

pkg_setup() {
	games_pkg_setup
	if ! built_with_use games-rpg/nwn-data sou || ! built_with_use games-rpg/nwn-data hou
	then
		eerror "${P} requires NWN v1.68, Shadows of Undrentide, and Hordes of"
		eerror "the Underdark. Please make sure you have all three before using"
		eerror "this patch."
		die "Requirements not met"
	fi
}

src_install() {
	local i
	for i in hak tlk erf
	do
		insinto "${dir}"/${i}
		doins *.${i} || die "${i} failed"
	done
	insinto "${dir}"/modules
	doins *.mod || die "mod failed"
	insinto "${dir}"/cep
	doins *.pdf || die "pdf failed"
	prepgamesdirs
}
