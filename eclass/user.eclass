# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/user.eclass,v 1.8 2011/11/03 00:59:16 vapier Exp $

# @ECLASS: user.eclass
# @MAINTAINER:
# base-system@gentoo.org (Linux)
# Joe Jezak <josejx@gmail.com> (OS X)
# usata@gentoo.org (OS X)
# Aaron Walker <ka0ttic@gentoo.org> (FreeBSD)
# @BLURB: user management in ebuilds
# @DESCRIPTION:
# The user eclass contains a suite of functions that allow ebuilds
# to quickly make sure users in the installed system are sane.

# @FUNCTION: _assert_pkg_ebuild_phase
# @INTERNAL
# @USAGE: <calling func name>
_assert_pkg_ebuild_phase() {
	case ${EBUILD_PHASE} in
	unpack|prepare|configure|compile|test|install)
		eerror "'$1()' called from '${EBUILD_PHASE}()' which is not a pkg_* function."
		eerror "Package fails at QA and at life.  Please file a bug."
		die "Bad package!  $1 is only for use in pkg_* functions!"
	esac
}

# @FUNCTION: egetent
# @USAGE: <database> <key>
# @DESCRIPTION:
# Small wrapper for getent (Linux), nidump (< Mac OS X 10.5),
# dscl (Mac OS X 10.5), and pw (FreeBSD) used in enewuser()/enewgroup().
#
# Supported databases: group passwd
egetent() {
	local db=$1 key=$2

	[[ $# -ge 3 ]] && die "usage: egetent <database> <key>"

	case ${db} in
	passwd|group) ;;
	*) die "sorry, database '${db}' not yet supported; file a bug" ;;
	esac

	case ${CHOST} in
	*-darwin[678])
		case ${key} in
		*[!0-9]*) # Non numeric
			nidump ${db} . | awk -F: "(\$1 ~ /^${key}\$/) {print;exit;}"
			;;
		*)	# Numeric
			nidump ${db} . | awk -F: "(\$3 == ${key}) {print;exit;}"
			;;
		esac
		;;
	*-darwin*)
		local mykey
		case ${db} in
		passwd) db="Users"  mykey="UniqueID" ;;
		group)  db="Groups" mykey="PrimaryGroupID" ;;
		esac

		case ${key} in
		*[!0-9]*) # Non numeric
			dscl . -read /${db}/${key} 2>/dev/null |grep RecordName
			;;
		*)	# Numeric
			dscl . -search /${db} ${mykey} ${key} 2>/dev/null
			;;
		esac
		;;
	*-freebsd*|*-dragonfly*)
		case ${db} in
		passwd) db="user" ;;
		*) ;;
		esac

		# lookup by uid/gid
		local opts
		if [[ ${key} == [[:digit:]]* ]] ; then
			[[ ${action} == "user" ]] && opts="-u" || opts="-g"
		fi

		pw show ${action} ${opts} "${key}" -q
		;;
	*-netbsd*|*-openbsd*)
		grep "${key}:\*:" /etc/${db}
		;;
	*)
		# ignore output if nscd doesn't exist, or we're not running as root
		nscd -i "${db}" 2>/dev/null
		getent "${db}" "${key}"
		;;
	esac
}

# @FUNCTION: enewuser
# @USAGE: <user> [uid] [shell] [homedir] [groups] [params]
# @DESCRIPTION:
# Same as enewgroup, you are not required to understand how to properly add
# a user to the system.  The only required parameter is the username.
# Default uid is (pass -1 for this) next available, default shell is
# /bin/false, default homedir is /dev/null, there are no default groups,
# and default params sets the comment as 'added by portage for ${PN}'.
enewuser() {
	_assert_pkg_ebuild_phase enewuser

	# get the username
	local euser=$1; shift
	if [[ -z ${euser} ]] ; then
		eerror "No username specified !"
		die "Cannot call enewuser without a username"
	fi

	# lets see if the username already exists
	if [[ -n $(egetent passwd "${euser}") ]] ; then
		return 0
	fi
	einfo "Adding user '${euser}' to your system ..."

	# options to pass to useradd
	local opts=

	# handle uid
	local euid=$1; shift
	if [[ -n ${euid} && ${euid} != -1 ]] ; then
		if [[ ${euid} -gt 0 ]] ; then
			if [[ -n $(egetent passwd ${euid}) ]] ; then
				euid="next"
			fi
		else
			eerror "Userid given but is not greater than 0 !"
			die "${euid} is not a valid UID"
		fi
	else
		euid="next"
	fi
	if [[ ${euid} == "next" ]] ; then
		for ((euid = 101; euid <= 999; euid++)); do
			[[ -z $(egetent passwd ${euid}) ]] && break
		done
	fi
	opts="${opts} -u ${euid}"
	einfo " - Userid: ${euid}"

	# handle shell
	local eshell=$1; shift
	if [[ ! -z ${eshell} ]] && [[ ${eshell} != "-1" ]] ; then
		if [[ ! -e ${ROOT}${eshell} ]] ; then
			eerror "A shell was specified but it does not exist !"
			die "${eshell} does not exist in ${ROOT}"
		fi
		if [[ ${eshell} == */false || ${eshell} == */nologin ]] ; then
			eerror "Do not specify ${eshell} yourself, use -1"
			die "Pass '-1' as the shell parameter"
		fi
	else
		for shell in /sbin/nologin /usr/sbin/nologin /bin/false /usr/bin/false /dev/null ; do
			[[ -x ${ROOT}${shell} ]] && break
		done

		if [[ ${shell} == "/dev/null" ]] ; then
			eerror "Unable to identify the shell to use, proceeding with userland default."
			case ${USERLAND} in
				GNU) shell="/bin/false" ;;
				BSD) shell="/sbin/nologin" ;;
				Darwin) shell="/usr/sbin/nologin" ;;
				*) die "Unable to identify the default shell for userland ${USERLAND}"
			esac
		fi

		eshell=${shell}
	fi
	einfo " - Shell: ${eshell}"
	opts="${opts} -s ${eshell}"

	# handle homedir
	local ehome=$1; shift
	if [[ -z ${ehome} ]] || [[ ${ehome} == "-1" ]] ; then
		ehome="/dev/null"
	fi
	einfo " - Home: ${ehome}"
	opts="${opts} -d ${ehome}"

	# handle groups
	local egroups=$1; shift
	if [[ ! -z ${egroups} ]] ; then
		local oldifs=${IFS}
		local defgroup="" exgroups=""

		export IFS=","
		for g in ${egroups} ; do
			export IFS=${oldifs}
			if [[ -z $(egetent group "${g}") ]] ; then
				eerror "You must add group ${g} to the system first"
				die "${g} is not a valid GID"
			fi
			if [[ -z ${defgroup} ]] ; then
				defgroup=${g}
			else
				exgroups="${exgroups},${g}"
			fi
			export IFS=","
		done
		export IFS=${oldifs}

		opts="${opts} -g ${defgroup}"
		if [[ ! -z ${exgroups} ]] ; then
			opts="${opts} -G ${exgroups:1}"
		fi
	else
		egroups="(none)"
	fi
	einfo " - Groups: ${egroups}"

	# handle extra and add the user
	local oldsandbox=${SANDBOX_ON}
	export SANDBOX_ON="0"
	case ${CHOST} in
	*-darwin*)
		### Make the user
		if [[ -z $@ ]] ; then
			dscl . create /users/${euser} uid ${euid}
			dscl . create /users/${euser} shell ${eshell}
			dscl . create /users/${euser} home ${ehome}
			dscl . create /users/${euser} realname "added by portage for ${PN}"
			### Add the user to the groups specified
			local oldifs=${IFS}
			export IFS=","
			for g in ${egroups} ; do
				dscl . merge /groups/${g} users ${euser}
			done
			export IFS=${oldifs}
		else
			einfo "Extra options are not supported on Darwin yet"
			einfo "Please report the ebuild along with the info below"
			einfo "eextra: $@"
			die "Required function missing"
		fi
		;;
	*-freebsd*|*-dragonfly*)
		if [[ -z $@ ]] ; then
			pw useradd ${euser} ${opts} \
				-c "added by portage for ${PN}" \
				die "enewuser failed"
		else
			einfo " - Extra: $@"
			pw useradd ${euser} ${opts} \
				"$@" || die "enewuser failed"
		fi
		;;

	*-netbsd*)
		if [[ -z $@ ]] ; then
			useradd ${opts} ${euser} || die "enewuser failed"
		else
			einfo " - Extra: $@"
			useradd ${opts} ${euser} "$@" || die "enewuser failed"
		fi
		;;

	*-openbsd*)
		if [[ -z $@ ]] ; then
			useradd -u ${euid} -s ${eshell} \
				-d ${ehome} -c "Added by portage for ${PN}" \
				-g ${egroups} ${euser} || die "enewuser failed"
		else
			einfo " - Extra: $@"
			useradd -u ${euid} -s ${eshell} \
				-d ${ehome} -c "Added by portage for ${PN}" \
				-g ${egroups} ${euser} "$@" || die "enewuser failed"
		fi
		;;

	*)
		if [[ -z $@ ]] ; then
			useradd -r ${opts} \
				-c "added by portage for ${PN}" \
				${euser} \
				|| die "enewuser failed"
		else
			einfo " - Extra: $@"
			useradd -r ${opts} "$@" \
				${euser} \
				|| die "enewuser failed"
		fi
		;;
	esac

	if [[ ! -e ${ROOT}/${ehome} ]] ; then
		einfo " - Creating ${ehome} in ${ROOT}"
		mkdir -p "${ROOT}/${ehome}"
		chown ${euser} "${ROOT}/${ehome}"
		chmod 755 "${ROOT}/${ehome}"
	fi

	export SANDBOX_ON=${oldsandbox}
}

# @FUNCTION: enewgroup
# @USAGE: <group> [gid]
# @DESCRIPTION:
# This function does not require you to understand how to properly add a
# group to the system.  Just give it a group name to add and enewgroup will
# do the rest.  You may specify the gid for the group or allow the group to
# allocate the next available one.
enewgroup() {
	_assert_pkg_ebuild_phase enewgroup

	# get the group
	local egroup="$1"; shift
	if [ -z "${egroup}" ]
	then
		eerror "No group specified !"
		die "Cannot call enewgroup without a group"
	fi

	# see if group already exists
	if [[ -n $(egetent group "${egroup}") ]]; then
		return 0
	fi
	einfo "Adding group '${egroup}' to your system ..."

	# options to pass to useradd
	local opts=

	# handle gid
	local egid="$1"; shift
	if [ ! -z "${egid}" ]
	then
		if [ "${egid}" -gt 0 ]
		then
			if [ -z "`egetent group ${egid}`" ]
			then
				if [[ "${CHOST}" == *-darwin* ]]; then
					opts="${opts} ${egid}"
				else
					opts="${opts} -g ${egid}"
				fi
			else
				egid="next available; requested gid taken"
			fi
		else
			eerror "Groupid given but is not greater than 0 !"
			die "${egid} is not a valid GID"
		fi
	else
		egid="next available"
	fi
	einfo " - Groupid: ${egid}"

	# handle extra
	local eextra="$@"
	opts="${opts} ${eextra}"

	# add the group
	local oldsandbox="${SANDBOX_ON}"
	export SANDBOX_ON="0"
	case ${CHOST} in
	*-darwin*)
		if [ ! -z "${eextra}" ];
		then
			einfo "Extra options are not supported on Darwin/OS X yet"
			einfo "Please report the ebuild along with the info below"
			einfo "eextra: ${eextra}"
			die "Required function missing"
		fi

		# If we need the next available
		case ${egid} in
		*[!0-9]*) # Non numeric
			for ((egid = 101; egid <= 999; egid++)); do
				[[ -z $(egetent group ${egid}) ]] && break
			done
		esac
		dscl . create /groups/${egroup} gid ${egid}
		dscl . create /groups/${egroup} passwd '*'
		;;

	*-freebsd*|*-dragonfly*)
		case ${egid} in
			*[!0-9]*) # Non numeric
				for ((egid = 101; egid <= 999; egid++)); do
					[[ -z $(egetent group ${egid}) ]] && break
				done
		esac
		pw groupadd ${egroup} -g ${egid} || die "enewgroup failed"
		;;

	*-netbsd*)
		case ${egid} in
		*[!0-9]*) # Non numeric
			for ((egid = 101; egid <= 999; egid++)); do
				[[ -z $(egetent group ${egid}) ]] && break
			done
		esac
		groupadd -g ${egid} ${egroup} || die "enewgroup failed"
		;;

	*)
		# We specify -r so that we get a GID in the system range from login.defs
		groupadd -r ${opts} ${egroup} || die "enewgroup failed"
		;;
	esac
	export SANDBOX_ON="${oldsandbox}"
}

# @FUNCTION: egethome
# @USAGE: <user>
# @DESCRIPTION:
# Gets the home directory for the specified user.
egethome() {
	local pos

	[[ $# -eq 1 ]] || die "usage: egethome <user>"

	case ${CHOST} in
	*-darwin*|*-freebsd*|*-dragonfly*)
		pos=9
		;;
	*)	# Linux, NetBSD, OpenBSD, etc...
		pos=6
		;;
	esac

	egetent passwd $1 | cut -d: -f${pos}
}

# @FUNCTION: egetshell
# @USAGE: <user>
# @DESCRIPTION:
# Gets the shell for the specified user.
egetshell() {
	local pos

	[[ $# -eq 1 ]] || die "usage: egetshell <user>"

	case ${CHOST} in
	*-darwin*|*-freebsd*|*-dragonfly*)
		pos=10
		;;
	*)	# Linux, NetBSD, OpenBSD, etc...
		pos=7
		;;
	esac

	egetent passwd "$1" | cut -d: -f${pos}
}
