# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/libtool.eclass,v 1.46 2005/05/11 15:15:03 azarah Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# This eclass patches ltmain.sh distributed with libtoolized packages with the
# relink and portage patch among others

ECLASS="libtool"
INHERITED="${INHERITED} ${ECLASS}"

# 2004.09.25 rac
# i have verified that at least one package can use this eclass and
# build properly even without libtool installed yet, probably using
# the files in the distribution.  eliminating this dependency fixes
# bug 65209, which is a showstopper for people doing installs using
# stageballs <3.  if anybody decides to revert this, please attempt
# to find an alternate way of resolving that bug at the same time.

DESCRIPTION="Based on the ${ECLASS} eclass"

ELIBTOOL_VERSION="2.0.2"

ELT_PATCH_DIR="${PORTDIR}/eclass/ELT-patches"
ELT_APPLIED_PATCHES=

#
# Returns all the directories containing ltmain.sh
#
ELT_find_ltmain_sh() {
	local x=
	local dirlist=

	for x in $(find "${S}" -name 'ltmain.sh') ; do
		dirlist="${dirlist} ${x%/*}"
	done

	echo "${dirlist}"
}

#
# See if we can apply $2 on $1, and if so, do it
#
ELT_try_and_apply_patch() {
	local ret=0
	local patch="$2"

	# We only support patchlevel of 0 - why worry if its static patches?
	if patch -p0 --dry-run $1 < ${patch} &> ${T}/elibtool.log ; then
		einfo "  Applying $(basename "$(dirname "${patch}")")-${patch##*/}.patch ..."
		patch -p0 $1 < ${patch} &>${T}/elibtool.log
		ret=$?
		export ELT_APPLIED_PATCHES="${ELT_APPLIED_PATCHES} ${patch##*/}"
	else
		ret=1
	fi

	return ${ret}
}

#
# Run through the patches in $2 and see if any
# apply to $1 ...
#
ELT_walk_patches() {
	local x=
	local y=
	local ret=1
	local patch_dir=
	local version=$(eval $(grep -e '^[[:space:]]*VERSION=' $1); \
					echo "${VERSION}")

	if [[ -n $2 ]] ; then
		if [[ -d ${ELT_PATCH_DIR}/$2 ]] ; then
			patch_dir="${ELT_PATCH_DIR}/$2"
		else
			return ${ret}
		fi

		if [[ -z ${version} ]] ; then
			eerror "Could not get VERSION for ${1##*/}!"
			die "Could not get VERSION for ${1##*/}!"
		fi

		# Go through the patches in reverse order (large to small)
		for x in $(ls -d "${patch_dir}"/* 2> /dev/null | sort -r) ; do
			if [[ -n ${x} && -f ${x} ]] ; then
				local ltver=$(VER_to_int "${version}")
				local ptver=$(VER_to_int "${x##*/}")
				
				# If libtool version smaller than patch version, skip patch.
				[[ ${ltver} -lt ${ptver} ]] && continue
				# For --remove-internal-dep ...
				if [[ -n $3 ]] ; then
					# For replace @REM_INT_DEP@ with what was passed
					# to --remove-internal-dep
					sed -e "s|@REM_INT_DEP@|$3|g" ${x} > \
						${T}/$$.rem_int_deps.patch

					x="${T}/$$.rem_int_deps.patch"
				fi

				if ELT_try_and_apply_patch "$1" "${x}" ; then
					ret=0
					break
				fi
			fi
		done
	fi

	return ${ret}
}

elibtoolize() {
	local x=
	local y=
	local do_portage="no"
	local do_reversedeps="no"
	local do_only_patches="no"
	local deptoremove=
	local my_dirlist=
	local elt_patches="portage relink max_cmd_len sed test tmp"
	local start_dir="${PWD}"

	my_dirlist="$(ELT_find_ltmain_sh)"

	for x in "$@" ; do
		case "${x}" in
			"--portage")
				# Only apply portage patch, and don't
				# 'libtoolize --copy --force' if all patches fail.
				do_portage="yes"
				;;
			"--reverse-deps")
				# Apply the reverse-deps patch
				# http://bugzilla.gnome.org/show_bug.cgi?id=75635
				do_reversedeps="yes"
				elt_patches="${elt_patches} fix-relink"
				;;
			"--patch-only")
				# Do not run libtoolize if none of the patches apply ..
				do_only_patches="yes"
				;;
			"^--remove-internal-dep="*)
				# We will replace @REM_INT_DEP@ with what is needed
				# in ELT_walk_patches() ...
				deptoremove="$(echo "${x}" | sed -e 's|--remove-internal-dep=||')"

				# Add the patch for this ...
				[ -n "${deptoremove}" ] && elt_patches="${elt_patches} rem-int-dep"
				;;
			"--shallow")
				# Only patch the ltmain.sh in ${S}
				if [ -f "${S}/ltmain.sh" ]
				then
					my_dirlist="${S}"
				else
					my_dirlist=
				fi
				;;
			"--no-uclibc")
				NO_UCLIBCTOOLIZE=1
				;;
			*)
				eerror "Invalid elibtoolize option: $x"
				die "elibtoolize called with $x ??"
		esac
	done

	if use ppc-macos ; then
		glibtoolize --copy --force
		darwintoolize
	fi

	for x in ${my_dirlist} ; do
		local tmp=$(echo "${x}" | sed -e "s|${S}||")
		export ELT_APPLIED_PATCHES=

		cd ${x}
		einfo "Patching \${S}$(echo "/${tmp}/ltmain.sh" | sed -e 's|//|/|g') ..."

		for y in ${elt_patches} ; do
			local ret=0

			case "${y}" in
				"rem-int-dep")
					ELT_walk_patches "${x}/ltmain.sh" "${y}" "${deptoremove}"
					ret=$?
					;;
				"fix-relink")
					# Do not apply if we do not have the relink patch applied ...
					if [[ -n $(grep 'inst_prefix_dir' "${x}/ltmain.sh") ]] ; then
						ELT_walk_patches "${x}/ltmain.sh" "${y}"
						ret=$?
					fi
					;;
				"max_cmd_len")
					# Do not apply if $max_cmd_len is not used ...
					if [[ -n $(grep 'max_cmd_len' "${x}/ltmain.sh") ]] ; then
						ELT_walk_patches "${x}/ltmain.sh" "${y}"
						ret=$?
					fi
					;;
				*)
					ELT_walk_patches "${x}/ltmain.sh" "${y}"
					ret=$?
					;;
			esac

			if [[ ${ret} -ne 0 ]] ; then
				case ${y} in
					"relink")
						# Critical patch, but could be applied ...
						if [[ -z $(grep 'inst_prefix_dir' "${x}/ltmain.sh") ]] ; then
							ewarn "  Could not apply relink.patch!"
						fi
						;;
					"portage")
						# Critical patch - for this one we abort, as it can really
						# cause breakage without it applied!
						if [[ ${do_portage} == "yes" ]] ; then
							# Stupid test to see if its already applied ...
							if [[ -z $(grep 'We do not want portage' "${x}/ltmain.sh") ]] ; then
								echo
								eerror "Portage patch requested, but failed to apply!"
								die "Portage patch requested, but failed to apply!"
							fi
						else
							if [[ -n $(grep 'We do not want portage' "${x}/ltmain.sh") ]] ; then
								ewarn "  Portage patch seems to be already applied."
								ewarn "  Please verify that it is not needed."
							else
							    local version=$( \
									eval $(grep -e '^[[:space:]]*VERSION=' "${x}/ltmain.sh"); \
									echo "${VERSION}")

								echo
								eerror "Portage patch failed to apply (ltmain.sh version ${version})!"
								die "Portage patch failed to apply!"
							fi
							# We do not want to run libtoolize ...
							ELT_APPLIED_PATCHES="portage"
						fi
						;;
				esac
			fi

			if [[ -z ${ELT_APPLIED_PATCHES} ]] ; then
				if [[ ${do_portage} == "no" && \
				      ${do_reversedeps} == "no" && \
					  ${do_only_patches} == "no" && \
				      ${deptoremove} == "" ]]
				then
					# Sometimes ltmain.sh is in a subdirectory ...
					if [[ ! -f ${x}/configure.in && ! -f ${x}/configure.ac ]] ; then
						if [[ -f ${x}/../configure.in || -f ${x}/../configure.ac ]] ; then
							cd "${x}"/../
						fi
					fi

					if type -p libtoolize &> /dev/null ; then
						ewarn "Cannot apply any patch, running libtoolize..."
						libtoolize --copy --force
					fi
					cd "${x}"
					break
				fi
			fi
		done
	done

	if [[ -f libtool ]] ; then
		rm -f libtool
	fi

	cd "${start_dir}"

	uclibctoolize
}

uclibctoolize() {
	[[ -n ${NO_UCLIBCTOOLIZE} ]] && return 0

	local errmsg=""
	[[ ${CTARGET:-${CHOST}} == *-uclibc ]] \
		&& errmsg="PLEASE CHECK" \
		|| errmsg="Already patched"
	local targets=""
	local x

	if [[ -z $* ]] ; then
		targets=$(find ${S} -name configure -o -name ltconfig)
	fi

	einfo "Applying uClibc/libtool patches ..."
	for x in ${targets} ; do
		[[ ! -s ${x} ]] && continue
		case ${x##*/} in
		configure)
			if grep 'Transform linux' "${x}" > /dev/null ; then
				ebegin " Fixing \${S}${x/${S}}"
				patch -p0 "${x}" "${ELT_PATCH_DIR}/uclibc/configure.patch" > /dev/null
				eend $? "${errmsg} ${x}"
			fi
			;;

		ltconfig)
			local ver=$(grep '^VERSION=' ${x})
			ver=${ver/VERSION=}
			[[ ${ver:0:3} == "1.4" ]] && ver="1.3"   # 1.4 and 1.3 are compat
			ebegin " Fixing \${S}${x/${S}}"
			patch -p0 "${x}" "${ELT_PATCH_DIR}/uclibc/ltconfig-${ver:0:3}.patch" > /dev/null
			eend $? "${errmsg} ${x}"
			;;
		esac
	done
}

darwintoolize() {
	local targets=""
	local x

	if [[ -z $* ]] ; then
		targets=$(find ${S} -name ltmain.sh -o -name ltconfig)
	fi

	einfo "Applying Darwin/libtool patches ..."
	for x in ${targets} ; do
		[[ ! -s ${x} ]] && continue
		case ${x##*/} in
		ltmain.sh|ltconfig)
			local ver=$(grep '^VERSION=' ${x})
			ver=${ver/VERSION=}
			if [[ ${ver:0:3} == "1.4" || ${ver:0:3} == "1.5" ]] ; then
				ver="1.3"   # 1.4, 1.5 and 1.3 are compat
			fi

			ebegin " Fixing \${S}${x/${S}}"
			patch -p0 "${x}" "${ELT_PATCH_DIR}/darwin/${x##*/}-${ver:0:3}.patch" > /dev/null
			eend $? "PLEASE CHECK ${x}"
			;;
		esac
	done
}

# char *VER_major(string)
#
#    Return the Major (X of X.Y.Z) version
#
VER_major() {
	[[ -z $1 ]] && return 1

	local VER=$@
	echo ${VER%%[^[:digit:]]*}
}

# char *VER_minor(string)
#
#    Return the Minor (Y of X.Y.Z) version
#
VER_minor() {
	[[ -z $1 ]] && return 1

	local VER=$@
	VER=${VER#*.}
	echo ${VER%%[^[:digit:]]*}
}

# char *VER_micro(string)
#
#    Return the Micro (Z of X.Y.Z) version.
#
VER_micro() {
	[[ -z $1 ]] && return 1

	local VER=$@
	VER=${VER#*.*.}
	echo ${VER%%[^[:digit:]]*}
}

# int VER_to_int(string)
#
#    Convert a string type version (2.4.0) to an int (132096)
#    for easy compairing or versions ...
#
VER_to_int() {
	[[ -z $1 ]] && return 1

	local VER_MAJOR=$(VER_major "$1")
	local VER_MINOR=$(VER_minor "$1")
	local VER_MICRO=$(VER_micro "$1")
	local VER_int=$(( VER_MAJOR * 65536 + VER_MINOR * 256 + VER_MICRO ))

	# We make version 1.0.0 the minimum version we will handle as
	# a sanity check ... if its less, we fail ...
	if [[ ${VER_int} -ge 65536 ]] ; then
		echo "${VER_int}"
		return 0
	fi

	echo 1
	return 1
}
