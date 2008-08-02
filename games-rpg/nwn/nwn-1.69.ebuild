# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.69.ebuild,v 1.1 2008/08/02 13:45:12 calchan Exp $

inherit eutils games

MY_PV=${PV//.}
PATCH_URL_BASE=http://files.bioware.com/neverwinternights/updates/linux/${MY_PV}/English_linuxclient${MY_PV}_

DESCRIPTION="role-playing game set in a huge medieval fantasy world of Dungeons and Dragons"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="http://dev.gentoo.org/~calchan/distfiles/nwn-libsdl-1.2.13.tar.bz2
	http://dev.gentoo.org/~calchan/distfiles/nwn-libelf-0.1.tar.bz2
	!sou? ( !hou? ( ${PATCH_URL_BASE}orig.tar.gz ) )
	sou? ( !hou? ( ${PATCH_URL_BASE}xp1.tar.gz ) )
	hou? ( ${PATCH_URL_BASE}xp2.tar.gz )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="sou hou"
RESTRICT="mirror strip"

RDEPEND=">=games-rpg/nwn-data-1.29-r3
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	!<games-rpg/nwmouse-0.1-r1
	x86? (
		=virtual/libstdc++-3.3
		x11-libs/libXext
		x11-libs/libX11 )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-xlibs )"
DEPEND=""

S=${WORKDIR}/nwn

GAMES_LICENSE_CHECK="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

die_from_busted_nwn-data() {
	local use=$*
	ewarn "You must emerge games-rpg/nwn-data with USE=$use. You can fix this"
	ewarn "by doing the following:"
	echo
	elog "mkdir -p /etc/portage"
	elog "echo 'games-rpg/nwn-data $use' >> /etc/portage/package.use"
	elog "emerge --oneshot games-rpg/nwn-data"
	die "nwn-data requires USE=$use"
}

pkg_setup() {
	games_pkg_setup
	if use sou
	then
		built_with_use games-rpg/nwn-data sou || die_from_busted_nwn-data sou
	fi
	if use hou
	then
		built_with_use games-rpg/nwn-data hou || die_from_busted_nwn-data hou
	fi
	built_with_use games-rpg/nwn-data linguas_en || die_from_busted_nwn-data linguas_en
}

src_unpack() {
	mkdir -p "${S}"/en
	cd "${S}"/en
	unpack ${A}
	mv lib ..
}

src_install() {
	exeinto "${dir}"
	doexe "${FILESDIR}"/fixinstall
	sed -i \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		-e "s:override miles nwm:miles:" \
		-e "s:chitin.key dialog.tlk nwmain:chitin.key:" \
		-e "s:^chmod a-x:#chmod a-x:" \
		"${Ddir}"/fixinstall || die "sed"
	if use hou || use sou
	then
		sed -i \
			-e "s:chitin.key patch.key:chitin.key:" \
			"${Ddir}"/fixinstall || die "sed"
	fi
	fperms ug+x "${dir}"/fixinstall || die "perms"
	mv "${S}"/* "${Ddir}"
	games_make_wrapper nwn ./nwn "${dir}" "${dir}"
	make_desktop_entry nwn "Neverwinter Nights"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "The included custom libSDL is patched to enable the following key sequences:"
	elog "  * Left-Alt & Enter - Iconify Window"
	elog "  * Right-Alt & Enter - Toggle between FullScreen/Windowed"
	elog "  * Left-Control & G - Disable the mouse grab that keeps the cursor inside the NWN window"
	elog "  * Right-Control & G - Re-enable the mouse grab to keep the cursor inside the NWN window"
	elog
	elog "The NWN linux client is now installed."
	elog "Proceed with the following step in order to get it working:"
	elog "Run ${dir}/fixinstall as root"
	echo
	ewarn "This version supports only english, see http://nwn.bioware.com/support/patch.html"
	ewarn "If you were playing with a different language you may want to backup your ~/.nwn and do:"
	ewarn "    mv  ~/.nwn/<language>  ~/.nwn/en"
	ewarn "If it does not work, try removing ~/.nwn, start nwn then quit, and re-import all you"
	ewarn "need (saves, etc...) in  ~/.nwn/en, but please do not file a bug."
}
