# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.67-r1.ebuild,v 1.3 2006/08/29 21:52:25 wolf31o2 Exp $

inherit eutils games

#http://files.bioware.com/neverwinternights/167/BioWare_NWN167_Tilesets_Full.zip

MY_PV=${PV//.}
#PATCH_URL_BASE=http://content.bioware.com/neverwinternights/linux/${MY_PV}/
PATCH_URL_BASE=http://files.bioware.com/neverwinternights/updates/linux/${MY_PV}/
DIALOG_URL_BASE=http://nwdownloads.bioware.com/neverwinternights/patch/dialog/
PACKAGE_NAME=_linuxclient${MY_PV}_orig.tar.gz
SOU_NAME=_linuxclient${MY_PV}_xp1.tar.gz
HOU_NAME=_linuxclient${MY_PV}_xp2.tar.gz

DESCRIPTION="Neverwinter Nights"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="linguas_fr? (
		${PATCH_URL_BASE}French${PACKAGE_NAME}
		${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip
		sou? ( ${PATCH_URL_BASE}French${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}French${HOU_NAME} ) )
	linguas_it? (
		${PATCH_URL_BASE}Italian${PACKAGE_NAME}
		${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip
		sou? ( ${PATCH_URL_BASE}Italian${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}Italian${HOU_NAME} ) )
	linguas_es? (
		${PATCH_URL_BASE}Spanish${PACKAGE_NAME}
		${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip
		sou? ( ${PATCH_URL_BASE}Spanish${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}Spanish${HOU_NAME} ) )
	linguas_de? (
		${PATCH_URL_BASE}German${PACKAGE_NAME}
		${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip
		sou? ( ${PATCH_URL_BASE}German${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}German${HOU_NAME} ) )
	!linguas_de? ( !linguas_fr? ( !linguas_es? ( !linguas_it? (
		${PATCH_URL_BASE}English${PACKAGE_NAME}
		${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip
		sou? ( ${PATCH_URL_BASE}English${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}English${HOU_NAME} ) ) ) ) )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="sou hou"
RESTRICT="mirror strip"

RDEPEND="games-rpg/nwn-data
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	x86? (
		=virtual/libstdc++-3.3
		|| (
			(
				x11-libs/libXext
				x11-libs/libX11 )
			virtual/x11 ) )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-xlibs )"
DEPEND="app-arch/unzip"

S="${WORKDIR}/nwn"

GAMES_LICENSE_CHECK="yes"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

die_from_busted_nwn-data() {
	local use=$*
	ewarn "You must emerge games-rpg/nwn-data with USE=$use.  You can fix this"
	ewarn "by doing the following:"
	echo
	einfo "mkdir -p /etc/portage"
	einfo "echo 'games-rpg/nwn-data $use' >> /etc/portage/package.use"
	einfo "emerge --oneshot games-rpg/nwn-data"
	die "nwn-data requires USE=$use"
}

pkg_setup() {
	games_pkg_setup
	declare -a LANGarray=($LINGUAS)
	if [ "${#LANGarray[*]}" == "0" ]
	then
		einfo "Setting default language to English."
	fi
	if use sou
	then
		built_with_use games-rpg/nwn-data sou || die_from_busted_nwn-data sou
	fi
	if use hou
	then
		built_with_use games-rpg/nwn-data hou || die_from_busted_nwn-data hou
	fi
	if use linguas_fr
	then
		built_with_use games-rpg/nwn-data linguas_fr || \
			die_from_busted_nwn-data linguas_fr
	fi
	if use linguas_it
	then
		built_with_use games-rpg/nwn-data linguas_it || \
			die_from_busted_nwn-data linguas_it
	fi
	if use linguas_es
	then
		built_with_use games-rpg/nwn-data linguas_es || \
			die_from_busted_nwn-data linguas_es
	fi
	if use linguas_de
	then
		built_with_use games-rpg/nwn-data linguas_de || \
			die_from_busted_nwn-data linguas_de
	fi
}

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	# the following is so ugly, please pretend it doesnt exist
	declare -a Aarray=(${A})
	unpack ${Aarray[0]}
	use sou && rm -f data/patch.bif patch.key && unpack ${Aarray[2]}
	use hou && rm -f data/patch.bif patch.key data/xp1patch.bif xp1patch.key \
		override/* && unpack ${Aarray[3]}
	unpack ${Aarray[1]}
}

src_install() {
	dodir ${dir}
	exeinto ${dir}
	doexe ${FILESDIR}/fixinstall
	sed -i \
		-e "s:GENTOO_USER:${GAMES_USER}:" \
		-e "s:GENTOO_GROUP:${GAMES_GROUP}:" \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}:" \
		${Ddir}/fixinstall || die "sed"
	if use hou || use sou
	then
		sed -i \
			-e "s:nwmain patch.key:nwmain:" \
			${Ddir}/fixinstall || die "sed"
	fi
	fperms ug+x ${dir}/fixinstall || die "perms"
	mv ${S}/* ${Ddir}
	games_make_wrapper nwn ./nwn "${dir}" "${dir}"
	make_desktop_entry nwn "Neverwinter Nights"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "The NWN linux client is now installed."
	einfo "Proceed with the following step in order to get it working:"
	einfo "Run ${dir}/fixinstall as root"
}
