# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-demodata/quake1-demodata-1.06.ebuild,v 1.3 2006/06/27 20:02:06 wolf31o2 Exp $

inherit eutils versionator games

MY_PV=$(delete_all_version_separators)
MY_PN="quake"

DESCRIPTION="Demo data for Quake 1"
HOMEPAGE="http://en.wikipedia.org/wiki/Quake_I"
SRC_URI="mirror://idsoftware/${MY_PN}/${MY_PN}${MY_PV}.zip"

# See licinfo.txt
LICENSE="quake1-demodata"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="symlink"

DEPEND="app-arch/lha"

S=${WORKDIR}
dir=${GAMES_DATADIR}/${MY_PN}1

pkg_setup() {
	games_pkg_setup

	if has_version "games-fps/quake1-data" ; then
		ewarn "games-fps/quake1-data already includes the demo data,"
		ewarn "so this installation is not very useful."
		echo
		if use symlink ; then
			eerror "The symlink for the demo data conflicts with the cdinstall data"
			die "Remove the 'symlink' USE flag for this package"
		fi
		ebeep
		epause
	fi
}

src_unpack() {
	unpack ${A}

	lha eq resource.1 || die "lha failed"
	# Don't want to conflict with the cdinstall files
	mv id1 demo
}

src_install() {
	insinto "${dir}"
	doins -r demo || die "doins -r failed"

	dodoc *.txt

	if use symlink ; then
		# Make the demo the default, so that people can just run it,
		# without having to mess with command-line options.
		cd "${D}/${dir}" && ln -sfn demo id1
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "This is just the demo data."
	einfo "You will still need a Quake 1 client, to play, such as darkplaces."
	echo

	if use symlink ; then
		einfo "id1 has been symlinked to demo, for convenience, within:"
		einfo "${dir}"
		echo
	fi
}
