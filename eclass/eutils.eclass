# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/eutils.eclass,v 1.4 2002/11/11 21:36:45 azarah Exp $
# This eclass is for general purpose functions that most ebuilds
# have to implement themselfs.
#
# NB:  If you add anything, please comment it!

ECLASS=eutils
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/patch

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
}


# Default directory where patches are located
EPATCH_SOURCE="${WORKDIR}/patch"
# Default extension for patches
EPATCH_SUFFIX="patch.bz2"
# Default options for patch
EPATCH_OPTS=""

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
		local EPATCH_SOURCE="$1/*.${EPATCH_SUFFIX}"
	else
		local EPATCH_SOURCE="${EPATCH_SOURCE}/*.${EPATCH_SUFFIX}"
	fi

	case ${EPATCH_SUFFIX##*\.} in
		bz2)
			PIPE_CMD="bzip2 -dc"
			;;
		gz)
			PIPE_CMD="gzip -dc"
			;;
		zip)
			PIPE_CMD="unzip -p"
			;;
		*)
			PIPE_CMD="cat"
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
		   [ -n "$1" -o "${x/_all_}" != "${x}" -o "`eval echo \$\{x/_${ARCH}_\}`" != "${x}" ]
		then
			local count=0
			local popts="${EPATCH_OPTS}"
			
			if [ "${SINGLE_PATCH}" = "yes" ]
			then
				einfo "Applying ${x##*/}..."
			else
				einfo "  ${x##*/}..."
			fi

			echo "*** Patch ${x##*/} ***" > ${STDERR_TARGET}

			# Allow for prefix to differ ... im lazy, so shoot me :/
			while [ "${count}" -lt 5 ]
			do
				if eval ${PIPE_CMD} ${x} | patch ${popts} --dry-run -f -p${count} 2>&1 >> ${STDERR_TARGET}
				then
					eval ${PIPE_CMD} ${x} | patch ${popts} -p${count} 2>&1 >> ${STDERR_TARGET}
					break
				fi

				count=$((count + 1))
			done

			if [ "${count}" -eq 5 ]
			then
				eerror "Failed Patch: ${x##*/}!"
				eerror
				eerror "Include in your bugreport the contents of:"
				eerror
				eerror "  ${STDERR_TARGET}"
				eerror
				die "Failed Patch: ${x##*/}!"
			fi

			eend 0
		fi
	done
	if [ "${SINGLE_PATCH}" = "no" ]
	then
		einfo "Done with patching"
	fi
}

