# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn/nwn-1.68-r1.ebuild,v 1.7 2007/08/18 01:02:17 wolf31o2 Exp $

inherit eutils games

LANGUAGES="linguas_fr linguas_it linguas_es linguas_de linguas_en"

MY_PV=${PV//.}
PATCH_URL_BASE=http://files.bioware.com/neverwinternights/updates/linux/${MY_PV}
PACKAGE_NAME=_linuxclient${MY_PV}_orig.tar.gz
SOU_NAME=_linuxclient${MY_PV}_xp1.tar.gz
HOU_NAME=_linuxclient${MY_PV}_xp2.tar.gz

DESCRIPTION="role-playing game set in a huge medieval fantasy world of Dungeons and Dragons"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="linguas_fr? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/French${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/French${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/French${HOU_NAME} ) )
	linguas_it? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/Italian${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/Italian${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/Italian${HOU_NAME} ) )
	linguas_en? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/English${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/English${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/English${HOU_NAME} ) )
	linguas_es? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/Spanish${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/Spanish${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/Spanish${HOU_NAME} ) )
	linguas_de? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/German${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/German${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/German${HOU_NAME} ) )
	!linguas_en? (
		!linguas_es? (
			!linguas_de? (
				!linguas_fr? (
					!linguas_it? (
		!sou? ( !hou? ( ${PATCH_URL_BASE}/English${PACKAGE_NAME} ) )
		sou? ( ${PATCH_URL_BASE}/English${SOU_NAME} )
		hou? ( ${PATCH_URL_BASE}/English${HOU_NAME} ) ) ) ) ) )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="sou hou ${LANGUAGES}"
# nowin USE flag not used anymore by pkg_setup()
RESTRICT="mirror strip"

RDEPEND=">=games-rpg/nwn-data-1.29-r1
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	x86? (
		=virtual/libstdc++-3.3
		x11-libs/libXext
		x11-libs/libX11 )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-xlibs )"
DEPEND="app-arch/unzip"

S=${WORKDIR}/nwn

GAMES_LICENSE_CHECK="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

die_from_busted_nwn-data() {
	local use=$*
	ewarn "You must emerge games-rpg/nwn-data with USE=$use.  You can fix this"
	ewarn "by doing the following:"
	echo
	elog "mkdir -p /etc/portage"
	elog "echo 'games-rpg/nwn-data $use' >> /etc/portage/package.use"
	elog "emerge --oneshot games-rpg/nwn-data"
	die "nwn-data requires USE=$use"
}

die_from_busted_linguas_nwn-data() {
	local use=$*
	ewarn "You must emerge games-rpg/nwn-data with LINGUAS=${use/linguas_/}."
	ewarn "You can fix this by doing the following:"
	echo
	elog "mkdir -p /etc/portage"
	elog "echo 'games-rpg/nwn-data $use' >> /etc/portage/package.use"
	elog "emerge --oneshot games-rpg/nwn-data"
	die "nwn-data requires LINGUAS='$use'"
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

	strip-linguas de en es fr it
#	currentlocale=""
#	for i in ${LINGUAS}
#	do
#		case ${i} in
#			de)
#				if [ ! -e "${dir}"/.metadata/linguas_de ]
#				then
#					use nowin && die_from_busted_linguas_nwn-data linguas_de
#				fi
#				currentlocale=de
#				;;
#			en)
#				if [ ! -e "${dir}"/.metadata/linguas_en ]
#				then
#					use nowin && die_from_busted_linguas_nwn-data linguas_en
#				fi
#				currentlocale=en
#				;;
#			es)
#				if [ ! -e "${dir}"/.metadata/linguas_es ]
#				then
#					use nowin && die_from_busted_linguas_nwn-data linguas_es
#				fi
#				currentlocale=es
#				;;
#			fr)
#				if [ ! -e "${dir}"/.metadata/linguas_fr ]
#				then
#					use nowin && die_from_busted_linguas_nwn-data linguas_fr
#				fi
#				currentlocale=fr
#				;;
#			it)
#				if [ ! -e "${dir}"/.metadata/linguas_it ]
#				then
#					use nowin && die_from_busted_linguas_nwn-data linguas_it
#				fi
#				currentlocale=it
#				;;
#		esac
#	done
}

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	mkdir -p .metadata
	for a in ${A}
	do
		if [ -z "${a/*orig*}" ]
		then
			currentlocale=""
			if [ -z "${a/*German*/}" ]
			then
				currentlocale=de
			elif [ -z "${a/*English*/}" ]
			then
				currentlocale=en
			elif [ -z "${a/*Spanish*/}" ]
			then
				currentlocale=es
			elif [ -z "${a/*Italian*/}" ]
			then
				currentlocale=it
			elif [ -z "${a/*French*/}" ]
			then
				currentlocale=fr
			fi
			if [ -n "$currentlocale" ]
			then
				mkdir -p "${currentlocale}"
				cd "${currentlocale}"
				unpack "${a}" || die "unpack ${a}"
				cd ..
			fi
		fi
	done
	use sou && (
	for a in ${A}
	do
		if [ -z "${a/*$SOU_NAME}" ]
		then
			currentlocale=""
			if [ -z "${a/*German*/}" ]
			then
				currentlocale=de
			elif [ -z "${a/*English*/}" ]
			then
				currentlocale=en
			elif [ -z "${a/*Spanish*/}" ]
			then
				currentlocale=es
			elif [ -z "${a/*Italian*/}" ]
			then
				currentlocale=it
			elif [ -z "${a/*French*/}" ]
			then
				currentlocale=fr
			fi
			if [ -n "$currentlocale" ]
			then
				cd "${currentlocale}"
				rm -f data/patch.bif patch.key
				unpack "${a}" || die "unpack ${a}"
				cd ..
			fi
		fi
	done )
	use hou && (
	for a in ${A}
	do
		if [ -z "${a/*$HOU_NAME}" ]
		then
			currentlocale=""
			if [ -z "${a/*German*/}" ]
			then
				currentlocale=de
			elif [ -z "${a/*English*/}" ]
			then
				currentlocale=en
			elif [ -z "${a/*Spanish*/}" ]
			then
				currentlocale=es
			elif [ -z "${a/*Italian*/}" ]
			then
				currentlocale=it
			elif [ -z "${a/*French*/}" ]
			then
				currentlocale=fr
			fi
			if [ -n "$currentlocale" ]
			then
				cd "${currentlocale}"
				rm -f data/patch.bif patch.key data/xp1patch.bif xp1patch.key override/*
				unpack "${a}" || die "unpack ${a}"
				cd ..
			fi
		fi
	done )
	for a in ${A}
	do
		if [ -z "${a/*dialog*}" ]
		then
			currentlocale=""
			if [ -z "${a/*German*/}" ]
			then
				currentlocale=de
			elif [ -z "${a/*English*/}" ]
			then
				currentlocale=en
			elif [ -z "${a/*Spanish*/}" ]
			then
				currentlocale=es
			elif [ -z "${a/*Italian*/}" ]
			then
				currentlocale=it
			elif [ -z "${a/*French*/}" ]
			then
				currentlocale=fr
			fi
			if [ -n "$currentlocale" ]
			then
				(cd "${currentlocale}" ; unpack ${a} ; cd .. )
			fi
		fi
	done
}

src_install() {
	dodir "${dir}"
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
	mv "${S}"/* ${Ddir}
	mv "${S}"/.metadata "${Ddir}"
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
