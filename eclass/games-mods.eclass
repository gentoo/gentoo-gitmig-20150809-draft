# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games-mods.eclass,v 1.40 2009/10/11 00:29:23 nyhm Exp $

# Variables to specify in an ebuild which uses this eclass:
# GAME - (doom3, quake4 or ut2004, etc), unless ${PN} starts with e.g. "doom3-"
# MOD_DESC - Description for the mod
# MOD_NAME - Creates a command-line wrapper and desktop icon for the mod
# MOD_DIR - Subdirectory name for the mod, if applicable
# MOD_ICON - Custom icon for the mod, instead of the default

inherit eutils games

EXPORT_FUNCTIONS src_install pkg_postinst

[[ -z ${GAME} ]] && GAME=${PN%%-*}

# Set our default title, icon, and cli options
case ${GAME} in
	doom3)
		GAME_PKGS="games-fps/doom3"
		GAME_TITLE="Doom 3"
		DEFAULT_MOD_ICON="doom3"
		SELECT_MOD="+set fs_game "
		GAME_EXE="doom3"
		DED_EXE="doom3-ded"
		DED_OPTIONS="+set dedicated 1 +exec server.cfg"
		DED_CFG_DIR=".doom3"
		;;
	enemy-territory)
		GAME_PKGS="games-fps/enemy-territory"
		GAME_TITLE="Enemy Territory"
		DEFAULT_MOD_ICON="ET"
		SELECT_MOD="+set fs_game "
		GAME_EXE="et"
		DED_EXE="et-ded"
		DED_OPTIONS="+set dedicated 1 +exec server.cfg"
		DED_CFG_DIR=".etwolf"
		;;
	quake3)
		GAME_PKGS="games-fps/quake3 games-fps/quake3-bin"
		GAME_TITLE="Quake III"
		DEFAULT_MOD_ICON="quake3"
		SELECT_MOD="+set fs_game "
		GAME_EXE="quake3"
		DED_EXE="quake3-ded"
		DED_OPTIONS="+set dedicated 1 +exec server.cfg"
		DED_CFG_DIR=".q3a"
		;;
	quake4)
		GAME_PKGS="games-fps/quake4-bin"
		GAME_TITLE="Quake 4"
		DEFAULT_MOD_ICON="/usr/share/pixmaps/quake4.bmp"
		SELECT_MOD="+set fs_game "
		GAME_EXE="quake4"
		DED_EXE="quake4-ded"
		DED_OPTIONS="+set dedicated 1 +exec server.cfg"
		DED_CFG_DIR=".quake4"
		;;
	ut2003)
		GAME_PKGS="games-fps/ut2003"
		GAME_TITLE="UT2003"
		DEFAULT_MOD_ICON="ut2003"
		SELECT_MOD="-mod="
		GAME_EXE="ut2003"
		DED_EXE="ucc"
		DED_OPTIONS=""
		DED_CFG_DIR=""
		;;
	ut2004)
		GAME_PKGS="games-fps/ut2004"
		GAME_TITLE="UT2004"
		DEFAULT_MOD_ICON="ut2004"
		SELECT_MOD="-mod="
		GAME_EXE="ut2004"
		DED_EXE="ut2004-ded"
		DED_OPTIONS=""
		DED_CFG_DIR=""
		;;
	*)
		eerror "This game is either not supported or you must set the GAME"
		eerror "variable to the proper game."
		die "unsupported game"
		;;
esac

games-mods_get_rdepend() {
	[[ $# -lt 1 ]] && die "${FUNCNAME}: need args"
	[[ $# -gt 1 ]] && echo -n "|| ( "

	case ${EAPI:-0} in
		0|1) echo -n $@ ;;
		2)
			local pkg
			for pkg in $@ ; do
				if [[ -z ${MOD_DIR} ]] ; then
					echo -n " ${pkg}"
				else
					echo -n " ${pkg}[dedicated=,opengl=]"
				fi
			done
			;;
	esac

	[[ $# -gt 1 ]] && echo -n " )"
}

DESCRIPTION="${GAME_TITLE} ${MOD_NAME} - ${MOD_DESC}"

SLOT="0"
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="$(games-mods_get_rdepend ${GAME_PKGS})"

S=${WORKDIR}

dir=${GAMES_DATADIR}/${GAME}

games-mods_use_opengl() {
	[[ -z ${MOD_DIR} ]] && return 1

	if use opengl || ! use dedicated ; then
		# Use opengl by default
		return 0
	fi

	return 1
}

games-mods_use_dedicated() {
	[[ -z ${MOD_DIR} ]] && return 1

	use dedicated && return 0 || return 1
}

games-mods_src_install() {
	local readme MOD_ICON_EXT new_bin_name bin_name
	INS_DIR=${dir}

	# If we have a README, install it
	for readme in README* ; do
		if [[ -s "${readme}" ]] ; then
			dodoc "${readme}" || die "dodoc failed"
		fi
	done

	if games-mods_use_opengl ; then
		if [[ -n "${MOD_ICON}" ]] ; then
			# Install custom icon
			MOD_ICON_EXT=${MOD_ICON##*.}
			if [[ -f ${MOD_ICON} ]] ; then
				newicon "${MOD_ICON}" ${PN}.${MOD_ICON_EXT}
			else
				newicon ${MOD_DIR}/"${MOD_ICON}" ${PN}.${MOD_ICON_EXT}
			fi
			case ${MOD_ICON_EXT} in
				bmp|ico)
					MOD_ICON=/usr/share/pixmaps/${PN}.${MOD_ICON_EXT}
					;;
				*)
					MOD_ICON=${PN}
					;;
			esac
		else
			# Use the game's standard icon
			MOD_ICON=${DEFAULT_MOD_ICON}
		fi

		# Set up command-line and desktop menu entries
		if [[ -n ${MOD_DIR} ]] ; then
			games_make_wrapper "${GAME_EXE}-${PN/${GAME}-}" \
				"${GAME_EXE} ${SELECT_MOD}${MOD_DIR}"
			make_desktop_entry "${GAME_EXE}-${PN/${GAME}-}" \
				"${GAME_TITLE} - ${MOD_NAME}" "${MOD_ICON}"
			# Since only quake3 has both a binary and a source-based install,
			# we only look for quake3 here.
			case "${GAME_EXE}" in
				"quake3")
					if has_version games-fps/quake3-bin ; then
						games_make_wrapper "${GAME_EXE}-bin-${PN/${GAME}-}" \
							"${GAME_EXE}-bin ${SELECT_MOD}${MOD_DIR}"
					fi
					make_desktop_entry "${GAME_EXE}-bin-${PN/${GAME}-}" \
						"${GAME_TITLE} - ${MOD_NAME} (binary)" \
						"${MOD_ICON}"
				;;
			esac
		fi
	fi

	# We expect anything not wanted to have been deleted by the ebuild
	insinto "${INS_DIR}"
	doins -r * || die "doins -r failed"

	# We are installing everything for these mods into ${INS_DIR},
	# ${GAMES_DATADIR}/${GAME} in most cases, and symlinking it
	# into ${GAMES_PREFIX_OPT}/${GAME} for each game.  This should
	# allow us to support both binary and source-based games easily.
	if [[ ${GAMES_PREFIX_OPT} != ${GAMES_DATADIR} ]] ; then
		pushd "${D}/${INS_DIR}" > /dev/null || die "pushd failed"
		local i
		for i in * ; do
			if [[ -d ${i} ]] ; then
				if [[ ${i} == ${MOD_DIR} ]] ; then
					dosym "${INS_DIR}/${i}" \
						"${GAMES_PREFIX_OPT}/${GAME}/${i}" \
						|| die "dosym ${i} failed"
				else
					local f
					while read f ; do
						dosym "${INS_DIR}/${f}" \
							"${GAMES_PREFIX_OPT}/${GAME}/${f}" \
							|| die "dosym ${f} failed"
					done < <(find "${i}" -type f)
				fi
			elif [[ -f ${i} ]] ; then
				dosym "${INS_DIR}/${i}" "${GAMES_PREFIX_OPT}/${GAME}/${i}" \
					|| die "dosym ${i} failed"
			else
				die "${i} shouldn't be there"
			fi
		done
		popd > /dev/null || die "popd failed"
	fi

	if games-mods_use_dedicated ; then
		if [[ -f ${FILESDIR}/server.cfg ]] ; then
			insinto "${GAMES_SYSCONFDIR}"/${GAME}/${MOD_DIR}
			doins "${FILESDIR}"/server.cfg || die "Copying server config"
			dodir "${GAMES_PREFIX}"/${DED_CFG_DIR}/${MOD_DIR}
			dosym "${GAMES_SYSCONFDIR}"/${GAME}/${MOD_DIR}/server.cfg \
				"${GAMES_PREFIX}"/${DED_CFG_DIR}/${MOD_DIR}/server.cfg
		fi
		games_make_wrapper \
			${GAME_EXE}-${PN/${GAME}-}-ded \
			"${DED_EXE} ${SELECT_MOD}${MOD_DIR} ${DED_OPTIONS}" 
		games-mods_make_initd
		games-mods_make_confd
	fi

	prepgamesdirs
}

games-mods_pkg_postinst() {
	games_pkg_postinst
	if games-mods_use_opengl ; then
		if [[ -n ${MOD_DIR} ]] ; then
			elog "To play this mod run:"
			elog " ${GAME_EXE}-${PN/${GAME}-}"
			echo
		fi
	fi
	if games-mods_use_dedicated ; then
		elog "To launch a dedicated server run:"
		elog " ${GAME_EXE}-${PN/${GAME}-}-ded"
		echo
		elog "To launch server at startup run:"
		elog " rc-update add ${GAME_EXE}-${PN/${GAME}-}-ded default"
		echo
	fi
}

games-mods_make_initd() {
	cat <<EOF > "${T}"/${GAME_EXE}-${PN/${GAME}-}-ded
#!/sbin/runscript
$(head -n 2 ${PORTDIR}/header.txt)
# Generated by games-mods.eclass

depend() {
	need net
}

start() {
	ebegin "Starting ${GAME_TITLE} ${MOD_NAME} dedicated server"
	start-stop-daemon --start --quiet --background --chuid \\
		${GAMES_USER_DED}:${GAMES_GROUP} --env HOME="${GAMES_PREFIX}" --exec \\
		${GAMES_BINDIR}/${GAME_EXE}-${PN/${GAME}-}-ded -- \\
		\${${GAME_EXE}_${PN/${GAME}-}_opts}
	eend \$?
}

stop() {
	ebegin "Stopping ${GAME_TITLE} ${MOD_NAME} dedicated server"
	start-stop-daemon --stop --quiet --exec \\
		${GAMES_BINDIR}/${GAME_EXE}-${PN/${GAME}-}-ded
	eend \$?
}
EOF

	doinitd "${T}"/${GAME_EXE}-${PN/${GAME}-}-ded || die "doinitd failed"
}

games-mods_make_confd() {
	cat <<-EOF > "${T}"/${GAME_EXE}-${PN/${GAME}-}-ded
	# Any extra options you want to pass to the dedicated server
	${GAME_EXE}_${PN/${GAME}-}_opts=""
	EOF

	doconfd "${T}"/${GAME_EXE}-${PN/${GAME}-}-ded || die "doconfd failed"
}
