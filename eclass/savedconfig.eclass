# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/savedconfig.eclass,v 1.1 2007/02/04 13:43:34 dragonheart Exp $

# Original Author: Daniel Black <dragonheart@gentoo.org>
#
# Purpose: Define an interface for ebuilds to save and restore
# complex configuration that may be edited by users.
#

# TODO
#
# - Move away from cp --parents because BSD doesn't like it

# Should I be using: $PORTAGE_CONFIGROOT ???? Whatever it means, whereever it is
# documented.

IUSE="savedconfig"

# save_config
#
# Saves the files and/or directories to
# /etc/portage/savedconfig/${CATEGORY}/${PF}
# If a single file is specified ${PF} is that file else it is a directory
# containing all specified files and directories.
#

save_config() {
	case ${EBUILD_PHASE} in
		preinst|install)
		;;
		*) die "Bad package!  save_config only for use in pkg_preinst or src_install functions!"
		;;
	esac
	case $# in
		0) die "Tell me what to save"
		    ;;
		1) if [[ -f "$1" ]]; then
				dodir /etc/portage/savedconfig/${CATEGORY}
				cp "$1" "${D}"/etc/portage/savedconfig/${CATEGORY}/${PF} \
					|| die "Failed to save $1"
			else
				dodir /etc/portage/savedconfig/${CATEGORY}/${PF}
				cp --parents -pPR "$1" "${D}"/etc/portage/savedconfig/${CATEGORY}/${PF} \
					|| die "Failed to save $1"
			fi
			;;
		*)
			dodir /etc/portage/savedconfig/${CATEGORY}/${PF}
			while [ "$1" ]; do
				cp --parents -pPR "$1" "${D}"/etc/portage/savedconfig/${CATEGORY}/${PF} \
					|| die "Failed to save $1"
				shift
			done
	esac
}


# restore_config
#
# Restores the configuation saved ebuild previously potentially with user edits
#
# Requires the name of the file to restore to if a single file was given to
# save_config. Otherwise it restores the directory structure.
#
# Looks for config files in the following order.
# ${ROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${PF}
# ${ROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${PF}
# ${ROOT}/etc/portage/savedconfig/${CATEGORY}/${PF}
# ${ROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${P}
# ${ROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${P}
# ${ROOT}/etc/portage/savedconfig/${CATEGORY}/${P}
# ${ROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${PN}
# ${ROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${PN}
# ${ROOT}/etc/portage/savedconfig/${CATEGORY}/${PN}
#
#

restore_config() {
	use savedconfig || return

	case ${EBUILD_PHASE} in
		unpack|compile)
		;;
		*) die "Bad package!  save_config only for use in pkg_preinst or src_install functions!"
		;;
	esac
	local found;
	local base=${ROOT}/etc/portage/savedconfig
	for check in {${CATEGORY}/${PF},${CATEGORY}/${P},${CATEGORY}/${PN}}; do
		configfile=${base}/${CTARGET}/${check}
		[[ -r ${configfile} ]] || configfile=${base}/${CHOST}/${check} 
		[[ -r ${configfile} ]] || configfile=${base}/${check} 
		einfo "Checking existence of ${configfile} ..."
		if [[ -r "${configfile}" ]]; then
			einfo "found ${configfile}"
			found=${configfile};
			break;
		fi
	done
	if [[ -f ${found} ]]; then
		if [ $# -gt 0 ]; then
			cp -pPR	"${found}" "$1" || die "Failed to restore ${found} to $1"
		else
			die "need to know the restoration filename"
		fi
	elif [[ -d ${found} ]]; then
		dest=${PWD}
		pushd "${found}"
		cp --parents . "${DEST}" \
			|| die "Failed to restore ${found} to $1"
		popd
	elif [[ -a {found} ]]; then 
		die "do not know how to handle non-file/directory ${found}"
	else
		eerror "No saved config to restore - please remove USE=saveconfig or"
		die "provide a configuration file in /etc/portage/savedconfig/${CATEGORY}/${PN}"
	fi
}


#warn_config() {
#
#}
