# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/eutils.eclass,v 1.40 2003/07/02 23:01:08 vapier Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# This eclass is for general purpose functions that most ebuilds
# have to implement themselves.
#
# NB:  If you add anything, please comment it!

ECLASS=eutils
INHERITED="$INHERITED $ECLASS"

DEPEND="$DEPEND !bootstrap? ( sys-devel/patch )"

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
EPATCH_OPTS=""
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
		"${ARCH}" = "arm" -o "${ARCH}" = "mips" ]
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

	elif [ "${ARCH}" = "ppc" ]
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
	if [ -z "${euser}" ] ; then
		eerror "No username specified !"
		die "Cannot call enewuser without a username"
	fi
	einfo "Adding user '${euser}' to your system ..."

	# setup a file for testing usernames/groups
	local tmpfile="`mktemp -p ${T}`"
	touch ${tmpfile}
	chown ${euser} ${tmpfile} >& /dev/null
	local realuser="`ls -l ${tmpfile} | awk '{print $3}'`"

	# see if user already exists
	if [ "${euser}" == "${realuser}" ] ; then
		einfo "${euser} already exists on your system :)"
		return 0
	fi

	# options to pass to useradd
	local opts=""

	# handle uid
	local euid="$1"; shift
	if [ ! -z "${euid}" ] && [ "${euid}" != "-1" ] ; then
		if [ ${euid} -gt 0 ] ; then
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
	if [ ! -z "${eshell}" ] ; then
		if [ ! -e ${eshell} ] ; then
			eerror "A shell was specified but it does not exist !"
			die "${eshell} does not exist"
		fi
	else
		eshell=/bin/false
	fi
	einfo " - Shell: ${eshell}"
	opts="${opts} -s ${eshell}"

	# handle homedir
	local ehome="$1"; shift
	if [ -z "${ehome}" ] ; then
		ehome=/dev/null
	fi
	einfo " - Home: ${ehome}"
	opts="${opts} -d ${ehome}"

	# handle groups
	local egroups="$1"; shift
	if [ ! -z "${egroups}" ] ; then
		local realgroup
		local oldifs="${IFS}"
		export IFS=","
		for g in ${egroups} ; do
			chgrp ${g} ${tmpfile} >& /dev/null
			realgroup="`ls -l ${tmpfile} | awk '{print $4}'`"
			if [ "${g}" != "${realgroup}" ] ; then
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
	local oldsandbox=${SANDBOX_ON}
	export SANDBOX_ON="0"
	if [ -z "${eextra}" ] ; then
		useradd ${opts} ${euser} \
			-c "added by portage for ${PN}" \
			|| die "enewuser failed"
	else
		einfo " - Extra: ${eextra}"
		useradd ${opts} ${euser} ${eextra} \
			|| die "enewuser failed"
	fi
	export SANDBOX_ON="${oldsandbox}"

	if [ ! -e ${ehome} ] && [ ! -e ${D}/${ehome} ] ; then
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
	if [ -z "${egroup}" ] ; then
		eerror "No group specified !"
		die "Cannot call enewgroup without a group"
	fi
	einfo "Adding group '${egroup}' to your system ..."

	# setup a file for testing groupname
	local tmpfile="`mktemp -p ${T}`"
	touch ${tmpfile}
	chgrp ${egroup} ${tmpfile} >& /dev/null
	local realgroup="`ls -l ${tmpfile} | awk '{print $4}'`"

	# see if group already exists
	if [ "${egroup}" == "${realgroup}" ] ; then
		einfo "${egroup} already exists on your system :)"
		return 0
	fi

	# options to pass to useradd
	local opts=""

	# handle gid
	local egid="$1"; shift
	if [ ! -z "${egid}" ] ; then
		if [ ${egid} -gt 0 ] ; then
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
	local oldsandbox=${SANDBOX_ON}
	export SANDBOX_ON="0"
	groupadd ${opts} ${egroup} || die "enewgroup failed"
	export SANDBOX_ON="${oldsandbox}"
}

# Simple script to replace 'dos2unix' binaries
# vapier@gentoo.org
#
# edos2unix(file, <more files>...)
edos2unix() {
	for f in $@ ; do
		cp ${f} ${T}/edos2unix
		sed 's/\r$//' ${T}/edos2unix > ${f}
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

	local exec=${1}
	local name=${2:-${PN}}
	local icon=${3:-${PN}.png}
	local type=${4}
	local path=${5:-${GAMES_PREFIX}}
	if [ -z "${type}" ] ; then
		case ${CATEGORY} in
			app-emulation)	type=Emulator	;;
			app-games)	type=Game	;;
			*)		type=""		;;
		esac
	fi
	local desktop=${T}/${exec}.desktop

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

	if [ -d /usr/share/applications ] ; then
		insinto /usr/share/applications
		doins ${desktop}
	fi

	#if [ -d /usr/share/gnome/apps ] ; then
	#	insinto /usr/share/gnome/apps/Games
	#	doins ${desktop}
	#fi

	#if [ ! -z "`ls /usr/kde/* 2>/dev/null`" ] ; then
	#	for ver in /usr/kde/* ; do
	#		insinto ${ver}/share/applnk/Games
	#		doins ${desktop}
	#	done
	#fi

	if [ -d /usr/share/applnk ] ; then
		insinto /usr/share/applnk/${type}
		doins ${desktop}
	fi

	return 0
}

# new convenience patch wrapper function to eventually replace epatch(), 
# $PATCHES, $PATCHES1, src_unpack:patch, src_unpack:autopatch and 
# /usr/bin/patch
# Features:
# - bulk patch handling similar to epatch()'s
# - automatic patch level detection like epatch()'s
# - automatic patch uncompression like epatch()'s
# - doesn't have the --dry-run overhead of epatch() - inspects patchfiles 
#   manually instead
# - once I decide it's production-ready, it'll be called from base_src_unpack
#   to handle $PATCHES to avoid defining src_unpack just to use xpatch

# accepts zero or more parameters specifying patchfiles and/or patchdirs

# known issues:
# - only supports unified style patches (does anyone _really_ use anything 
#   else?)
# - because it doesn't use --dry-run there is a risk of it failing
#   to find the files to patch, ie detect the patchlevel, properly. It doesn't use
#   any of the backup heuristics that patch employs to discover a filename.
#   however, this isn't dangerous because if it works for the developer who's
#   writing the ebuild, it'll always work for the users, and if it doesn't,
#   then we'll fix it :-)
# - no support as yet for patches applying outside $S (and not directly in $WORKDIR).
xpatch() {

	debug-print-function $FUNCNAME $*

	local list=""
	local list2=""
	declare -i plevel

	# parse patch sources
	for x in $*; do
		debug-print "$FUNCNAME: parsing parameter $x"
		if [ -f "$x" ]; then
			list="$list $x"
		elif [ -d "$x" ]; then
			# handles patchdirs like epatch() for now: no recursion.
			# patches are sorted by filename, so with an xy_foo naming scheme you'll get the right order.
			# only patches with _$ARCH_ or _all_ in their filenames are applied.
			for file in `ls -A $x`; do
				debug-print "$FUNCNAME:  parsing in subdir: file $file"
				if [ -f "$x/$file" ] && [ "${file}" != "${file/_all_}" -o "${file}" != "${file/_$ARCH_}" ]; then
					list2="$list2 $x/$file"
				fi
			done
			list="`echo $list2 | sort` $list"
		else
			die "Couldn't find $x"
		fi
	done

	debug-print "$FUNCNAME: final list of patches: $list"

	for x in $list; do
		debug-print "$FUNCNAME: processing $x"
		# deal with compressed files. /usr/bin/file is in the system profile, or should be.
		case "`/usr/bin/file -b $x`" in
			*gzip*) patchfile="${T}/current.patch"; ungzip -c "$x" > "${patchfile}";;
			*bzip2*) patchfile="${T}/current.patch"; bunzip2 -c "$x" > "${patchfile}";;
			*text*) patchfile="$x";;
			*) die "Could not determine filetype of patch $x";;
		esac
		debug-print "$FUNCNAME: patchfile=$patchfile"

		# determine patchlevel. supports p0 and higher with either $S or $WORKDIR as base.
		target="`/bin/grep -m 1 '^+++ ' $patchfile`"
		debug-print "$FUNCNAME: raw target=$target"
		# strip target down to the path/filename, remove leading +++
		target="${target/+++ }"; target="${target%%	*}"
		# duplicate slashes are discarded by patch wrt the patchlevel. therefore we need
		# to discard them as well to calculate the correct patchlevel.
		target="${target//\/\//\/}"
		debug-print "$FUNCNAME: stripped target=$target"

		# look for target
		for basedir in "$S" "$WORKDIR" "${PWD}"; do
			debug-print "$FUNCNAME: looking in basedir=$basedir"
			cd "$basedir"

			# try stripping leading directories
			target2="$target"
			plevel=0
			debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
			while [ ! -f "$target2" ]; do
				target2="${target2#*/}" # removes piece of target2 upto the first occurence of /
				plevel=plevel+1
				debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
				[ "$target2" == "${target2/\/}" ] && break
			done
			test -f "$target2" && break

			# try stripping filename - needed to support patches creating new files
			target2="${target%/*}"
			plevel=0
			debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
			while [ ! -d "$target2" ]; do
				target2="${target2#*/}" # removes piece of target2 upto the first occurence of /
				plevel=plevel+1
				debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
				[ "$target2" == "${target2/\/}" ] && break
			done
			test -d "$target2" && break

		done

		test -f "${basedir}/${target2}" || test -d "${basedir}/${target2}" || die "Could not determine patchlevel for $x"
		debug-print "$FUNCNAME: determined plevel=$plevel"
		# do the patching
		ebegin "Applying patch ${x##*/}..."
		/usr/bin/patch -p$plevel < "$patchfile" > /dev/null || die "Failed to apply patch $x"
		eend $?

	done

}
