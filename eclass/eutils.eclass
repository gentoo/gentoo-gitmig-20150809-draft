# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/eutils.eclass,v 1.79 2004/02/12 02:00:46 vapier Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# This eclass is for general purpose functions that most ebuilds
# have to implement themselves.
#
# NB:  If you add anything, please comment it!

ECLASS=eutils
INHERITED="$INHERITED $ECLASS"

newdepend "!bootstrap? ( sys-devel/patch )"

DESCRIPTION="Based on the ${ECLASS} eclass"

# This function generate linker scripts in /usr/lib for dynamic
# libs in /lib.  This is to fix linking problems when you have
# the .so in /lib, and the .a in /usr/lib.  What happens is that
# in some cases when linking dynamic, the .a in /usr/lib is used
# instead of the .so in /lib due to gcc/libtool tweaking ld's
# library search path.  This cause many builds to fail.
# See bug #4411 for more info.
#
# To use, simply call:
#
#   gen_usr_ldscript libfoo.so
#
# Note that you should in general use the unversioned name of
# the library, as ldconfig should usually update it correctly
# to point to the latest version of the library present.
#
# <azarah@gentoo.org> (26 Oct 2002)
#
gen_usr_ldscript() {

	# Just make sure it exists
	dodir /usr/lib

	cat > ${D}/usr/lib/$1 <<"END_LDSCRIPT"
/* GNU ld script
   Because Gentoo have critical dynamic libraries
   in /lib, and the static versions in /usr/lib, we
   need to have a "fake" dynamic lib in /usr/lib,
   otherwise we run into linking problems.
   See bug #4411 on http://bugs.gentoo.org/ for
   more info.  */
GROUP ( /lib/libxxx )
END_LDSCRIPT

	dosed "s:libxxx:$1:" /usr/lib/$1

	return 0
}

# Simple function to draw a line consisting of '=' the same length as $*
#
# <azarah@gentoo.org> (11 Nov 2002)
#
draw_line() {
	local i=0
	local str_length=""

	# Handle calls that do not have args, or wc not being installed ...
	if [ -z "$1" -o ! -x "$(which wc 2>/dev/null)" ]
	then
		echo "==============================================================="
		return 0
	fi

	# Get the length of $*
	str_length="$(echo -n "$*" | wc -m)"

	while [ "$i" -lt "${str_length}" ]
	do
		echo -n "="

		i=$((i + 1))
	done

	echo

	return 0
}

# Default directory where patches are located
EPATCH_SOURCE="${WORKDIR}/patch"
# Default extension for patches
EPATCH_SUFFIX="patch.bz2"
# Default options for patch
# Set -g0 to keep RCS, ClearCase, Perforce and SCCS happy. Bug #24571
EPATCH_OPTS="-g0"
# List of patches not to apply.  Not this is only file names,
# and not the full path ..
EPATCH_EXCLUDE=""
# Change the printed message for a single patch.
EPATCH_SINGLE_MSG=""
# Force applying bulk patches even if not following the style:
#
#   ??_${ARCH}_foo.${EPATCH_SUFFIX}
#
EPATCH_FORCE="no"

# This function is for bulk patching, or in theory for just one
# or two patches.
#
# It should work with .bz2, .gz, .zip and plain text patches.
# Currently all patches should be the same format.
#
# You do not have to specify '-p' option to patch, as it will
# try with -p0 to -p5 until it succeed, or fail at -p5.
#
# Above EPATCH_* variables can be used to control various defaults,
# bug they should be left as is to ensure an ebuild can rely on
# them for.
#
# Patches are applied in current directory.
#
# Bulk Patches should preferibly have the form of:
#
#   ??_${ARCH}_foo.${EPATCH_SUFFIX}
#
# For example:
#
#   01_all_misc-fix.patch.bz2
#   02_sparc_another-fix.patch.bz2
#
# This ensures that there are a set order, and you can have ARCH
# specific patches.
#
# If you however give an argument to epatch(), it will treat it as a
# single patch that need to be applied if its a file.  If on the other
# hand its a directory, it will set EPATCH_SOURCE to this.
#
# <azarah@gentoo.org> (10 Nov 2002)
#
epatch() {
	local PIPE_CMD=""
	local STDERR_TARGET="${T}/$$.out"
	local PATCH_TARGET="${T}/$$.patch"
	local PATCH_SUFFIX=""
	local SINGLE_PATCH="no"
	local x=""

	if [ "$#" -gt 1 ]
	then
		eerror "Invalid arguments to epatch()"
		die "Invalid arguments to epatch()"
	fi

	if [ -n "$1" -a -f "$1" ]
	then
		SINGLE_PATCH="yes"

		local EPATCH_SOURCE="$1"
		local EPATCH_SUFFIX="${1##*\.}"

	elif [ -n "$1" -a -d "$1" ]
	then
		# Allow no extension if EPATCH_FORCE=yes ... used by vim for example ...
		if [ "${EPATCH_FORCE}" = "yes" ] && [ -z "${EPATCH_SUFFIX}" ]
		then
			local EPATCH_SOURCE="$1/*"
		else
			local EPATCH_SOURCE="$1/*.${EPATCH_SUFFIX}"
		fi
	else
		if [ ! -d ${EPATCH_SOURCE} ]
		then
			if [ -n "$1" -a "${EPATCH_SOURCE}" = "${WORKDIR}/patch" ]
			then
				EPATCH_SOURCE="$1"
			fi

			echo
			eerror "Cannot find \$EPATCH_SOURCE!  Value for \$EPATCH_SOURCE is:"
			eerror
			eerror "  ${EPATCH_SOURCE}"
			echo
			die "Cannot find \$EPATCH_SOURCE!"
		fi

		local EPATCH_SOURCE="${EPATCH_SOURCE}/*.${EPATCH_SUFFIX}"
	fi

	case ${EPATCH_SUFFIX##*\.} in
		bz2)
			PIPE_CMD="bzip2 -dc"
			PATCH_SUFFIX="bz2"
			;;
		gz|Z|z)
			PIPE_CMD="gzip -dc"
			PATCH_SUFFIX="gz"
			;;
		ZIP|zip)
			PIPE_CMD="unzip -p"
			PATCH_SUFFIX="zip"
			;;
		*)
			PIPE_CMD="cat"
			PATCH_SUFFIX="patch"
			;;
	esac

	if [ "${SINGLE_PATCH}" = "no" ]
	then
		einfo "Applying various patches (bugfixes/updates)..."
	fi
	for x in ${EPATCH_SOURCE}
	do
		# New ARCH dependant patch naming scheme...
		#
		#   ???_arch_foo.patch
		#
		if [ -f ${x} ] && \
		   ([ "${SINGLE_PATCH}" = "yes" -o "${x/_all_}" != "${x}" -o "`eval echo \$\{x/_${ARCH}_\}`" != "${x}" ] || \
		    [ "${EPATCH_FORCE}" = "yes" ])
		then
			local count=0
			local popts="${EPATCH_OPTS}"

			if [ -n "${EPATCH_EXCLUDE}" ]
			then
				if [ "`eval echo \$\{EPATCH_EXCLUDE/${x##*/}\}`" != "${EPATCH_EXCLUDE}" ]
				then
					continue
				fi
			fi

			if [ "${SINGLE_PATCH}" = "yes" ]
			then
				if [ -n "${EPATCH_SINGLE_MSG}" ]
				then
					einfo "${EPATCH_SINGLE_MSG}"
				else
					einfo "Applying ${x##*/}..."
				fi
			else
				einfo "  ${x##*/}..."
			fi

			echo "***** ${x##*/} *****" > ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
			echo >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}

			# Allow for prefix to differ ... im lazy, so shoot me :/
			while [ "${count}" -lt 5 ]
			do
				# Generate some useful debug info ...
				draw_line "***** ${x##*/} *****" >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
				echo >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}

				if [ "${PATCH_SUFFIX}" != "patch" ]
				then
					echo -n "PIPE_COMMAND:  " >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
					echo "${PIPE_CMD} ${x} > ${PATCH_TARGET}" >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
				else
					PATCH_TARGET="${x}"
				fi

				echo -n "PATCH COMMAND:  " >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
				echo "patch ${popts} -p${count} < ${PATCH_TARGET}" >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}

				echo >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
				draw_line "***** ${x##*/} *****" >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}

				if [ "${PATCH_SUFFIX}" != "patch" ]
				then
					if ! (${PIPE_CMD} ${x} > ${PATCH_TARGET}) >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/} 2>&1
					then
						echo
						eerror "Could not extract patch!"
						#die "Could not extract patch!"
						count=5
						break
					fi
				fi

				if (cat ${PATCH_TARGET} | patch ${popts} --dry-run -f -p${count}) >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/} 2>&1
				then
					draw_line "***** ${x##*/} *****" >	${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real
					echo >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real
					echo "ACTUALLY APPLYING ${x##*/}..." >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real
					echo >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real
					draw_line "***** ${x##*/} *****" >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real

					cat ${PATCH_TARGET} | patch ${popts} -p${count} >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real 2>&1

					if [ "$?" -ne 0 ]
					then
						cat ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real >> ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}
						echo
						eerror "A dry-run of patch command succeeded, but actually"
						eerror "applying the patch failed!"
						#die "Real world sux compared to the dreamworld!"
						count=5
					fi

					rm -f ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}.real

					break
				fi

				count=$((count + 1))
			done

			if [ "${PATCH_SUFFIX}" != "patch" ]
			then
				rm -f ${PATCH_TARGET}
			fi

			if [ "${count}" -eq 5 ]
			then
				echo
				eerror "Failed Patch: ${x##*/}!"
				eerror
				eerror "Include in your bugreport the contents of:"
				eerror
				eerror "  ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}"
				echo
				die "Failed Patch: ${x##*/}!"
			fi

			rm -f ${STDERR_TARGET%/*}/${x##*/}-${STDERR_TARGET##*/}

			eend 0
		fi
	done
	if [ "${SINGLE_PATCH}" = "no" ]
	then
		einfo "Done with patching"
	fi
}

# This function return true if we are using the NPTL pthreads
# implementation.
#
# <azarah@gentoo.org> (06 March 2003)
#

have_NPTL() {

	cat > ${T}/test-nptl.c <<-"END"
		#define _XOPEN_SOURCE
		#include <unistd.h>
		#include <stdio.h>

		int main()
		{
		  char buf[255];
		  char *str = buf;

		  confstr(_CS_GNU_LIBPTHREAD_VERSION, str, 255);
		  if (NULL != str) {
		    printf("%s\n", str);
		    if (NULL != strstr(str, "NPTL"))
		      return 0;
		  }

		  return 1;
		}
	END

	einfon "Checking for _CS_GNU_LIBPTHREAD_VERSION support in glibc ... "
	if gcc -o ${T}/nptl ${T}/test-nptl.c &> /dev/null
	then
		echo "yes"
		einfon "Checking what PTHREADS implementation we have ... "
		if ${T}/nptl
		then
			return 0
		else
			return 1
		fi
	else
		echo "no"
	fi

	return 1
}

# This function check how many cpu's are present, and then set
# -j in MAKEOPTS accordingly.
#
# Thanks to nall <nall@gentoo.org> for this.
#
get_number_of_jobs() {
	local jobs=0

	if [ ! -r /proc/cpuinfo ]
	then
		return 1
	fi

	# This bit is from H?kan Wessberg <nacka-gentoo@refug.org>, bug #13565.
	if [ "`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | wc -l`" -gt 0 ]
	then
		ADMINOPTS="`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | cut -d= -f2 | sed 's/\"//g'`"
		ADMINPARAM="`echo ${ADMINOPTS} | gawk '{match($0, /-j *[0-9]*/, opt); print opt[0]}'`"
		ADMINPARAM="${ADMINPARAM/-j}"
	fi

	export MAKEOPTS="`echo ${MAKEOPTS} | sed -e 's:-j *[0-9]*::g'`"

	if [ "${ARCH}" = "amd64" -o "${ARCH}" = "x86" -o "${ARCH}" = "hppa" -o \
		"${ARCH}" = "arm" -o "${ARCH}" = "mips" -o "${ARCH}" = "ia64" ]
	then
		# these archs will always have "[Pp]rocessor"
		jobs="$((`grep -c ^[Pp]rocessor /proc/cpuinfo` * 2))"

	elif [ "${ARCH}" = "sparc" -o "${ARCH}" = "sparc64" ]
	then
		# sparc always has "ncpus active"
		jobs="$((`grep "^ncpus active" /proc/cpuinfo | sed -e "s/^.*: //"` * 2))"

	elif [ "${ARCH}" = "alpha" ]
	then
		# alpha has "cpus active", but only when compiled with SMP
		if [ "`grep -c "^cpus active" /proc/cpuinfo`" -eq 1 ]
		then
			jobs="$((`grep "^cpus active" /proc/cpuinfo | sed -e "s/^.*: //"` * 2))"
		else
			jobs=2
		fi

	elif [ "${ARCH}" = "ppc" -o "${ARCH}" = "ppc64" ]
	then
		# ppc has "processor", but only when compiled with SMP
		if [ "`grep -c "^processor" /proc/cpuinfo`" -eq 1 ]
		then
			jobs="$((`grep -c ^processor /proc/cpuinfo` * 2))"
		else
			jobs=2
		fi
	else
		jobs="$((`grep -c ^cpu /proc/cpuinfo` * 2))"
		die "Unknown ARCH -- ${ARCH}!"
	fi

	# Make sure the number is valid ...
	if [ "${jobs}" -lt 1 ]
	then
		jobs=1
	fi

	if [ -n "${ADMINPARAM}" ]
	then
		if [ "${jobs}" -gt "${ADMINPARAM}" ]
		then
			einfo "Setting make jobs to \"-j${ADMINPARAM}\" to ensure successful merge..."
			export MAKEOPTS="${MAKEOPTS} -j${ADMINPARAM}"
		else
			einfo "Setting make jobs to \"-j${jobs}\" to ensure successful merge..."
			export MAKEOPTS="${MAKEOPTS} -j${jobs}"
		fi
	fi
}

# Cheap replacement for when debianutils (and thus mktemp)
# do not exist on the users system
# vapier@gentoo.org
#
# Takes just 1 parameter (the directory to create tmpfile in)
mymktemp() {
	local topdir="$1"
	
	[ -z "${topdir}" ] && topdir=/tmp
	if [ "`which mktemp 2>/dev/null`" ]
	then
		mktemp -p ${topdir}
	else
		local tmp="${topdir}/tmp.${RANDOM}.${RANDOM}.${RANDOM}"
		touch ${tmp}
		echo ${tmp}
	fi
}

# Simplify/standardize adding users to the system
# vapier@gentoo.org
#
# enewuser(username, uid, shell, homedir, groups, extra options)
#
# Default values if you do not specify any:
# username:	REQUIRED !
# uid:		next available (see useradd(8))
#		note: pass -1 to get default behavior
# shell:	/bin/false
# homedir:	/dev/null
# groups:	none
# extra:	comment of 'added by portage for ${PN}'
enewuser() {
	# get the username
	local euser="$1"; shift
	if [ -z "${euser}" ]
	then
		eerror "No username specified !"
		die "Cannot call enewuser without a username"
	fi

	# setup a file for testing usernames/groups
	local tmpfile="`mymktemp ${T}`"
	chown ${euser} ${tmpfile} >& /dev/null
	local realuser="`ls -l ${tmpfile} | awk '{print $3}'`"

	# see if user already exists
	if [ "${euser}" == "${realuser}" ]
	then
		return 0
	fi
	einfo "Adding user '${euser}' to your system ..."

	# options to pass to useradd
	local opts=

	# handle uid
	local euid="$1"; shift
	if [ ! -z "${euid}" ] && [ "${euid}" != "-1" ]
	then
		if [ "${euid}" -gt 0 ]
		then
			opts="${opts} -u ${euid}"
		else
			eerror "Userid given but is not greater than 0 !"
			die "${euid} is not a valid UID"
		fi
	else
		euid="next available"
	fi
	einfo " - Userid: ${euid}"

	# handle shell
	local eshell="$1"; shift
	if [ ! -z "${eshell}" ] && [ "${eshell}" != "-1" ]
	then
		if [ ! -e "${eshell}" ]
		then
			eerror "A shell was specified but it does not exist !"
			die "${eshell} does not exist"
		fi
	else
		eshell="/bin/false"
	fi
	einfo " - Shell: ${eshell}"
	opts="${opts} -s ${eshell}"

	# handle homedir
	local ehome="$1"; shift
	if [ -z "${ehome}" ] && [ "${eshell}" != "-1" ]
	then
		ehome="/dev/null"
	fi
	einfo " - Home: ${ehome}"
	opts="${opts} -d ${ehome}"

	# handle groups
	local egroups="$1"; shift
	if [ ! -z "${egroups}" ]
	then
		local realgroup=
		local oldifs="${IFS}"
		export IFS=","
		for g in ${egroups}
		do
			chgrp ${g} ${tmpfile} >& /dev/null
			realgroup="`ls -l ${tmpfile} | awk '{print $4}'`"
			if [ "${g}" != "${realgroup}" ]
			then
				eerror "You must add ${g} to the system first"
				die "${g} is not a valid GID"
			fi
		done
		export IFS="${oldifs}"
		opts="${opts} -g ${egroups}"
	else
		egroups="(none)"
	fi
	einfo " - Groups: ${egroups}"

	# handle extra and add the user
	local eextra="$@"
	local oldsandbox="${SANDBOX_ON}"
	export SANDBOX_ON="0"
	if [ -z "${eextra}" ]
	then
		useradd ${opts} ${euser} \
			-c "added by portage for ${PN}" \
			|| die "enewuser failed"
	else
		einfo " - Extra: ${eextra}"
		useradd ${opts} ${euser} ${eextra} \
			|| die "enewuser failed"
	fi
	export SANDBOX_ON="${oldsandbox}"

	if [ ! -e "${ehome}" ] && [ ! -e "${D}/${ehome}" ]
	then
		einfo " - Creating ${ehome} in ${D}"
		dodir ${ehome}
		fowners ${euser} ${ehome}
		fperms 755 ${ehome}
	fi
}

# Simplify/standardize adding groups to the system
# vapier@gentoo.org
#
# enewgroup(group, gid)
#
# Default values if you do not specify any:
# groupname:	REQUIRED !
# gid:		next available (see groupadd(8))
# extra:	none
enewgroup() {
	# get the group
	local egroup="$1"; shift
	if [ -z "${egroup}" ]
	then
		eerror "No group specified !"
		die "Cannot call enewgroup without a group"
	fi

	# setup a file for testing groupname
	local tmpfile="`mymktemp ${T}`"
	chgrp ${egroup} ${tmpfile} >& /dev/null
	local realgroup="`ls -l ${tmpfile} | awk '{print $4}'`"

	# see if group already exists
	if [ "${egroup}" == "${realgroup}" ]
	then
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
			opts="${opts} -g ${egid}"
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
	groupadd ${opts} ${egroup} || die "enewgroup failed"
	export SANDBOX_ON="${oldsandbox}"
}

# Simple script to replace 'dos2unix' binaries
# vapier@gentoo.org
#
# edos2unix(file, <more files>...)
edos2unix() {
	for f in "$@"
	do
		cp "${f}" ${T}/edos2unix
		sed 's/\r$//' ${T}/edos2unix > "${f}"
	done
}

# Make a desktop file !
# Great for making those icons in kde/gnome startmenu !
# Amaze your friends !  Get the women !  Join today !
# gnome2 /usr/share/applications
# gnome1 /usr/share/gnome/apps/
# KDE ${KDEDIR}/share/applnk /usr/share/applnk
#
# make_desktop_entry(<binary>, [name], [icon], [type], [path])
#
# binary:	what binary does the app run with ?
# name:		the name that will show up in the menu
# icon:		give your little like a pretty little icon ...
#		this can be relative (to /usr/share/pixmaps) or
#		a full path to an icon
# type:		what kind of application is this ?  for categories:
#		http://www.freedesktop.org/standards/menu/draft/menu-spec/menu-spec.html
# path:		if your app needs to startup in a specific dir
make_desktop_entry() {
	[ -z "$1" ] && eerror "You must specify the executable" && return 1

	local exec="${1}"
	local name="${2:-${PN}}"
	local icon="${3:-${PN}.png}"
	local type="${4}"
	local path="${5:-${GAMES_PREFIX}}"
	if [ -z "${type}" ]
	then
		case ${CATEGORY} in
			"app-emulation")
				type=Emulator
				;;
			"games-"*)
				type=Game
				;;
			"net-"*)
				type=Network;
				;;
			*)
				type=
				;;
		esac
	fi
	local desktop="${T}/${exec}.desktop"

echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.2
Name=${name}
Type=Application
Comment=${DESCRIPTION}
Exec=${exec}
Path=${path}
Icon=${icon}
Categories=Application;${type};" > ${desktop}

	if [ -d "/usr/share/applications" ]
	then
		insinto /usr/share/applications
		doins ${desktop}
	fi

	#if [ -d "/usr/share/gnome/apps" ]
	#then
	#	insinto /usr/share/gnome/apps/Games
	#	doins ${desktop}
	#fi

	#if [ ! -z "`ls /usr/kde/* 2>/dev/null`" ]
	#then
	#	for ver in /usr/kde/*
	#	do
	#		insinto ${ver}/share/applnk/Games
	#		doins ${desktop}
	#	done
	#fi

	if [ -d "/usr/share/applnk" ]
	then
		insinto /usr/share/applnk/${type}
		doins ${desktop}
	fi

	return 0
}

# for internal use only (unpack_pdv and unpack_makeself)
find_unpackable_file() {
	local src="$1"
	if [ -z "${src}" ]
	then
		src="${DISTDIR}/${A}"
	else
		if [ -e "${DISTDIR}/${src}" ]
		then
			src="${DISTDIR}/${src}"
		elif [ -e "${PWD}/${src}" ]
		then
			src="${PWD}/${src}"
		elif [ -e "${src}" ]
		then
			src="${src}"
		fi
	fi
	[ ! -e "${src}" ] && die "Could not find requested archive ${src}"
	echo "${src}"
}

# Unpack those pesky pdv generated files ...
# They're self-unpacking programs with the binary package stuffed in
# the middle of the archive.  Valve seems to use it a lot ... too bad
# it seems to like to segfault a lot :(.  So lets take it apart ourselves.
#
# Usage: unpack_pdv [file to unpack] [size of off_t]
# - you have to specify the off_t size ... i have no idea how to extract that
#   information out of the binary executable myself.  basically you pass in
#   the size of the off_t type (in bytes) on the machine that built the pdv
#   archive.  one way to determine this is by running the following commands:
#   strings <pdv archive> | grep lseek
#   strace -elseek <pdv archive>
#   basically look for the first lseek command (we do the strings/grep because
#   sometimes the function call is _llseek or something) and steal the 2nd
#   parameter.  here is an example:
#   root@vapier 0 pdv_unpack # strings hldsupdatetool.bin | grep lseek
#   lseek
#   root@vapier 0 pdv_unpack # strace -elseek ./hldsupdatetool.bin
#   lseek(3, -4, SEEK_END)                  = 2981250
#   thus we would pass in the value of '4' as the second parameter.
unpack_pdv() {
	local src="`find_unpackable_file $1`"
	local sizeoff_t="$2"

	[ -z "${sizeoff_t}" ] && die "No idea what off_t size was used for this pdv :("

	local shrtsrc="`basename ${src}`"
	echo ">>> Unpacking ${shrtsrc} to ${PWD}"
	local metaskip=`tail -c ${sizeoff_t} ${src} | hexdump -e \"%i\"`
	local tailskip=`tail -c $((${sizeoff_t}*2)) ${src} | head -c ${sizeoff_t} |  hexdump -e \"%i\"`

	# grab metadata for debug reasons
	local metafile="`mymktemp ${T}`"
	tail -c +$((${metaskip}+1)) ${src} > ${metafile}

	# rip out the final file name from the metadata
	local datafile="`tail -c +$((${metaskip}+1)) ${src} | strings | head -n 1`"
	datafile="`basename ${datafile}`"

	# now lets uncompress/untar the file if need be
	local tmpfile="`mymktemp ${T}`"
	tail -c +$((${tailskip}+1)) ${src} 2>/dev/null | head -c 512 > ${tmpfile}

	local iscompressed="`file -b ${tmpfile}`"
	if [ "${iscompressed:0:8}" == "compress" ] ; then
		iscompressed=1
		mv ${tmpfile}{,.Z}
		gunzip ${tmpfile}
	else
		iscompressed=0
	fi
	local istar="`file -b ${tmpfile}`"
	if [ "${istar:0:9}" == "POSIX tar" ] ; then
		istar=1
	else
		istar=0
	fi

	#for some reason gzip dies with this ... dd cant provide buffer fast enough ?
	#dd if=${src} ibs=${metaskip} count=1 \
	#	| dd ibs=${tailskip} skip=1 \
	#	| gzip -dc \
	#	> ${datafile}
	if [ ${iscompressed} -eq 1 ] ; then
		if [ ${istar} -eq 1 ] ; then
			tail -c +$((${tailskip}+1)) ${src} 2>/dev/null \
				| head -c $((${metaskip}-${tailskip})) \
				| tar -xzf -
		else
			tail -c +$((${tailskip}+1)) ${src} 2>/dev/null \
				| head -c $((${metaskip}-${tailskip})) \
				| gzip -dc \
				> ${datafile}
		fi
	else
		if [ ${istar} -eq 1 ] ; then
			tail -c +$((${tailskip}+1)) ${src} 2>/dev/null \
				| head -c $((${metaskip}-${tailskip})) \
				| tar --no-same-owner -xf -
		else
			tail -c +$((${tailskip}+1)) ${src} 2>/dev/null \
				| head -c $((${metaskip}-${tailskip})) \
				> ${datafile}
		fi
	fi
	true
	#[ -s "${datafile}" ] || die "failure unpacking pdv ('${metaskip}' '${tailskip}' '${datafile}')"
	#assert "failure unpacking pdv ('${metaskip}' '${tailskip}' '${datafile}')"
}

# Unpack those pesky makeself generated files ...
# They're shell scripts with the binary package tagged onto
# the end of the archive.  Loki utilized the format as does
# many other game companies.
#
# Usage: unpack_makeself [file to unpack] [offset]
# - If the file is not specified then unpack will utilize ${A}.
# - If the offset is not specified then we will attempt to extract
#   the proper offset from the script itself.
unpack_makeself() {
	local src="`find_unpackable_file $1`"
	local skip="$2"

	local shrtsrc="`basename ${src}`"
	echo ">>> Unpacking ${shrtsrc} to ${PWD}"
	if [ -z "${skip}" ]
	then
		local ver="`grep -a '#.*Makeself' ${src} | awk '{print $NF}'`"
		local skip=0
		case ${ver} in
			1.5.*)	# tested 1.5.{3,4,5} ... guessing 1.5.x series is same
				skip=`grep -a ^skip= ${src} | cut -d= -f2`
				;;
			2.0|2.0.1)
				skip=`grep -a ^$'\t'tail ${src} | awk '{print $2}' | cut -b2-`
				;;
			2.1.1)
				skip=`grep -a ^offset= ${src} | awk '{print $2}' | cut -b2-`
				let skip="skip + 1"
				;;
			2.1.2)
				skip=`grep -a ^offset= ${src} | awk '{print $3}' | head -n 1`
				let skip="skip + 1"
				;;
			2.1.3)
				skip=`grep -a ^offset= ${src} | awk '{print $3}'`
				let skip="skip + 1"
				;;
			*)
				eerror "I'm sorry, but I was unable to support the Makeself file."
				eerror "The version I detected was '${ver}'."
				eerror "Please file a bug about the file ${shrtsrc} at"
				eerror "http://bugs.gentoo.org/ so that support can be added."
				die "makeself version '${ver}' not supported"
				;;
		esac
		debug-print "Detected Makeself version ${ver} ... using ${skip} as offset"
	fi

	# lets grab the first few bytes of the file to figure out what kind of archive it is
	local tmpfile="`mymktemp ${T}`"
	tail -n +${skip} ${src} 2>/dev/null | head -c 512 > ${tmpfile}
	local filetype="`file -b ${tmpfile}`"
	case ${filetype} in
		*tar\ archive)
			tail -n +${skip} ${src} | tar --no-same-owner -xf -
			;;
		bzip2*)
			tail -n +${skip} ${src} | bzip2 -dc | tar --no-same-owner -xf -
			;;
		gzip*)
			tail -n +${skip} ${src} | tar --no-same-owner -xzf -
			;;
		*)
			false
			;;
	esac
	assert "failure unpacking (${filetype}) makeself ${shrtsrc} ('${ver}' +${skip})"
}

# Display a license for user to accept.
#
# Usage: check_license [license]
# - If the file is not specified then ${LICENSE} is used.
check_license() {
	local lic=$1
	if [ -z "${lic}" ] ; then
		lic="${PORTDIR}/licenses/${LICENSE}"
	else
		if [ -e "${PORTDIR}/licenses/${src}" ] ; then
			lic="${PORTDIR}/licenses/${src}"
		elif [ -e "${PWD}/${src}" ] ; then
			lic="${PWD}/${src}"
		elif [ -e "${src}" ] ; then
			lic="${src}"
		fi
	fi
	[ ! -f "${lic}" ] && die "Could not find requested license ${src}"
	local l="`basename ${lic}`"

	# here is where we check for the licenses the user already
	# accepted ... if we don't find a match, we make the user accept
	local alic
	for alic in "${ACCEPT_LICENSE}" ; do
		[ "${alic}" == "*" ] && return 0
		[ "${alic}" == "${l}" ] && return 0
	done

	local licmsg="`mymktemp ${T}`"
	cat << EOF > ${licmsg}
**********************************************************
The following license outlines the terms of use of this
package.  You MUST accept this license for installation to
continue.  When you are done viewing, hit 'q'.  If you
CTRL+C out of this, the install will not run!
**********************************************************

EOF
	cat ${lic} >> ${licmsg}
	${PAGER:-less} ${licmsg} || die "Could not execute pager (${PAGER}) to accept ${lic}"
	einfon "Do you accept the terms of this license (${l})? [yes/no] "
	read alic
	case ${alic} in
		yes|Yes|y|Y)
			return 0
			;;
		*)
			echo;echo;echo
			eerror "You MUST accept the license to continue!  Exiting!"
			die "Failed to accept license"
			;;
	esac
}

# Aquire cd(s) for those lovely cd-based emerges.  Yes, this violates
# the whole 'non-interactive' policy, but damnit I want CD support !
#
# with these cdrom functions we handle all the user interaction and
# standardize everything.  all you have to do is call cdrom_get_cds()
# and when the function returns, you can assume that the cd has been
# found at CDROM_ROOT.
#
# normally the cdrom functions will refer to the cds as 'cd #1', 'cd #2',
# etc...  if you want to give the cds better names, then just export
# the CDROM_NAME_X variables before calling cdrom_get_cds().
#
# for those multi cd ebuilds, see the cdrom_load_next_cd() below.
#
# Usage: cdrom_get_cds <file on cd1> [file on cd2] [file on cd3] [...]
# - this will attempt to locate a cd based upon a file that is on
#   the cd ... the more files you give this function, the more cds
#   the cdrom functions will handle
cdrom_get_cds() {
	# first we figure out how many cds we're dealing with by
	# the # of files they gave us
	local cdcnt=0
	local f=
	for f in "$@" ; do
		cdcnt=$((cdcnt + 1))
		export CDROM_CHECK_${cdcnt}="$f"
	done
	export CDROM_TOTAL_CDS=${cdcnt}
	export CDROM_CURRENT_CD=1

	# now we see if the user gave use CD_ROOT ...
	# if they did, let's just believe them that it's correct
	if [ ! -z "${CD_ROOT}" ] ; then
		export CDROM_ROOT="${CD_ROOT}"
		einfo "Found CD #${CDROM_CURRENT_CD} root at ${CDROM_ROOT}"
		return
	fi
	# do the same for CD_ROOT_X
	if [ ! -z "${CD_ROOT_1}" ] ; then
		local var=
		cdcnt=0
		while [ ${cdcnt} -lt ${CDROM_TOTAL_CDS} ] ; do
			cdcnt=$((cdcnt + 1))
			var="CD_ROOT_${cdcnt}"
			if [ -z "${!var}" ] ; then
				eerror "You must either use just the CD_ROOT"
				eerror "or specify ALL the CD_ROOT_X variables."
				eerror "In this case, you will need ${CDROM_TOTAL_CDS} CD_ROOT_X variables."
				die "could not locate CD_ROOT_${cdcnt}"
			fi
			export CDROM_ROOTS_${cdcnt}="${!var}"
		done
		export CDROM_ROOT=${CDROM_ROOTS_1}
		einfo "Found CD #${CDROM_CURRENT_CD} root at ${CDROM_ROOT}"
		return
	fi

	if [ ${CDROM_TOTAL_CDS} -eq 1 ] ; then
		einfon "This ebuild will need the "
		if [ -z "${CDROM_NAME}" ] ; then
			echo "cdrom for ${PN}."
		else
			echo "${CDROM_NAME}."
		fi
		echo
		einfo "If you do not have the CD, but have the data files"
		einfo "mounted somewhere on your filesystem, just export"
		einfo "the variable CD_ROOT so that it points to the"
		einfo "directory containing the files."
		echo
	else
		einfo "This package will need access to ${CDROM_TOTAL_CDS} cds."
		cdcnt=0
		while [ ${cdcnt} -lt ${CDROM_TOTAL_CDS} ] ; do
			cdcnt=$((cdcnt + 1))
			var="CDROM_NAME_${cdcnt}"
			[ ! -z "${!var}" ] && einfo " CD ${cdcnt}: ${!var}"
		done
		echo
		einfo "If you do not have the CDs, but have the data files"
		einfo "mounted somewhere on your filesystem, just export"
		einfo "the following variables so they point to the right place:"
		einfon ""
		cdcnt=0
		while [ ${cdcnt} -lt ${CDROM_TOTAL_CDS} ] ; do
			cdcnt=$((cdcnt + 1))
			echo -n " CD_ROOT_${cdcnt}"
		done
		echo
		einfo "Or, if you have all the files in the same place, or"
		einfo "you only have one cdrom, you can export CD_ROOT"
		einfo "and that place will be used as the same data source"
		einfo "for all the CDs."
		echo
	fi
	export CDROM_CURRENT_CD=0
	cdrom_load_next_cd
}

# this is only used when you need access to more than one cd.
# when you have finished using the first cd, just call this function.
# when it returns, CDROM_ROOT will be pointing to the second cd.
# remember, you can only go forward in the cd chain, you can't go back.
cdrom_load_next_cd() {
	export CDROM_CURRENT_CD=$((CDROM_CURRENT_CD + 1))
	local var=

	if [ ! -z "${CD_ROOT}" ] ; then
		einfo "Using same root as before for CD #${CDROM_CURRENT_CD}"
		return
	fi

	unset CDROM_ROOT
	var=CDROM_ROOTS_${CDROM_CURRENT_CD}
	if [ -z "${!var}" ] ; then
		var="CDROM_CHECK_${CDROM_CURRENT_CD}"
		cdrom_locate_file_on_cd ${!var}
	else
		export CDROM_ROOT="${!var}"
	fi

	einfo "Found CD #${CDROM_CURRENT_CD} root at ${CDROM_ROOT}"
}

# this is used internally by the cdrom_get_cds() and cdrom_load_next_cd()
# functions.  this should *never* be called from an ebuild.
# all it does is try to locate a give file on a cd ... if the cd isn't
# found, then a message asking for the user to insert the cdrom will be
# displayed and we'll hang out here until:
# (1) the file is found on a mounted cdrom
# (2) the user hits CTRL+C
cdrom_locate_file_on_cd() {
	while [ -z "${CDROM_ROOT}" ] ; do
		local dir="$(dirname ${@})"
		local file="$(basename ${@})"
		local mline=""
		local showedmsg=0

		for mline in `mount | egrep -e '(iso|cdrom)' | awk '{print $3}'` ; do
			[ -d "${mline}/${dir}" ] || continue
			[ ! -z "$(find ${mline}/${dir} -iname ${file} -maxdepth 1)" ] \
				&& export CDROM_ROOT=${mline}
		done

		if [ -z "${CDROM_ROOT}" ] ; then
			echo
			if [ ${showedmsg} -eq 0 ] ; then
				if [ ${CDROM_TOTAL_CDS} -eq 1 ] ; then
					if [ -z "${CDROM_NAME}" ] ; then
						einfo "Please insert the cdrom for ${PN} now !"
					else
						einfo "Please insert the ${CDROM_NAME} cdrom now !"
					fi
				else
					if [ -z "${CDROM_NAME_1}" ] ; then
						einfo "Please insert cd #${CDROM_CURRENT_CD} for ${PN} now !"
					else
						local var="CDROM_NAME_${CDROM_CURRENT_CD}"
						einfo "Please insert+mount the ${!var} cdrom now !"
					fi
				fi
				showedmsg=1
			fi
			einfo "Press return to scan for the cd again"
			einfo "or hit CTRL+C to abort the emerge."
			read
		fi
	done
}
