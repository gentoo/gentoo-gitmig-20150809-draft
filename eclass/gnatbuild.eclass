# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnatbuild.eclass,v 1.5 2006/02/17 22:18:20 swegener Exp $

# ATTN!
# set HOMEPAGE and LICENSE in appropriate ebuild, as we have
# gnat developed at two locations now.

inherit versionator toolchain-funcs flag-o-matic multilib

EXPORT_FUNCTIONS pkg_setup pkg_postinst pkg_prerm src_unpack src_compile src_install

DESCRIPTION="Based on the ${ECLASS} eclass"

IUSE="nls multilib"

RDEPEND="app-admin/eselect-gnat"

#---->> globals and SLOT <<----

# just a check, this location seems to vary too much, easier to track it in
# ebuild
#[ -z "${GNATSOURCE}" ] && die "please set GNATSOURCE in ebuild! (before inherit)"

# versioning
# because of gnatpro/gnatgpl we need to track both gcc and gnat versions

# these simply default to $PV
GNATMAJOR=$(get_version_component_range 1)
GNATMINOR=$(get_version_component_range 2)
GNATBRANCH=$(get_version_component_range 1-2)
GNATRELEASE=$(get_version_component_range 1-3)

# GCCVER and SLOT logic
#
# I better define vars for package names, as there was discussion on proper
# naming and it may change
PN_GnatGCC="gnat-gcc"
PN_GnatGpl="gnat-gpl"
PN_GnatPro="gnat-pro"

# ATTN! GCCVER stands for the provided backend gcc, not the one on the system
# so tc-* functions are of no use here
#
# GCCVER can be set in the ebuild, but then care will have to be taken
# to set it before inheriting, which is easy to forget
# so set it here for what we can..
if   [[ ${PN} == "${PN_GnatGCC}" ]] ; then
	GCCVER="${PV}"
elif [[ ${PN} == "${PN_GnatGpl}" ]] ; then
	GCCVER="${GNATRELEASE}"
elif [[ ${PN} == "${PN_GnatPro}" ]] ; then
# Ada Core provided stuff is really conservative and changes backends rarely
	case "${GNATMAJOR}" in
		"3")    GCCVER="2.8.1" ;;
		"2005") GCCVER="3.4.5" ;;
	esac
else
	# gpc, gdc and possibly others will use a lot of common logic, I'll try to
	# provide some support for them via this eclass
	die "no support for other gcc frontends so far. Sorry."
fi

# finally extract GCC version strings
GCCMAJOR=$(get_version_component_range 1 "${GCCVER}")
GCCMINOR=$(get_version_component_range 2 "${GCCVER}")
GCCBRANCH=$(get_version_component_range 1-2 "${GCCVER}")
GCCRELEASE=$(get_version_component_range 1-3 "${GCCVER}")

# SLOT logic, make it represent gcc backend, as this is what matters most
SLOT="${GCCBRANCH}"

# possible future crosscompilation support
export CTARGET=${CTARGET:-${CHOST}}

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}


# set our install locations
PREFIX=${GNATBUILD_PREFIX:-/usr} # not sure we need this hook, but may be..
LIBPATH=${PREFIX}/lib/${PN}/${CTARGET}/${SLOT}
LIBEXECPATH=${PREFIX}/libexec/${PN}/${CTARGET}/${SLOT}
INCLUDEPATH=${LIBPATH}/include
BINPATH=${PREFIX}/${CTARGET}/${PN}-bin/${SLOT}
DATAPATH=${PREFIX}/share/${PN}-data/${CTARGET}/${SLOT}

# ebuild globals
if [[ ${PN} == "${PN_GnatPro}" ]] && [[ ${GNATMAJOR} == "3" ]]; then
		DEPEND="x86? ( >=app-shells/tcsh-6.0 )"
fi
S="${WORKDIR}/gcc-${GCCVER}"

# bootstrap globals, common to src_unpack and src_compile
case $(tc-arch) in
	ppc)
		GNATBOOT="${WORKDIR}/gnat-3.15p-powerpc-unknown-linux-gnu"
		GNATBOOTINST="${GNATBOOT}"
		GCC_EXEC_BASE="${GNATBOOT}/lib/gcc-lib"
		;;
	amd64 | x86)
		GNATBOOT="${WORKDIR}/usr"
		;;
esac

# some buildtime globals
GNATBUILD="${WORKDIR}/build"

# necessary for detecting lib locations and creating env.d entry
#XGCC="${GNATBUILD}/gcc/xgcc -B${GNATBUILD}/gcc"

#----<< globals and SLOT >>----

# set SRC_URI's in ebuilds for now

#----<< support checks >>----
# skipping this section - do not care about hardened/multilib for now

#---->> specs + env.d logic <<----
# TODO!!!
# set MANPATH, etc..
#----<< specs + env.d logic >>----


#---->> some helper functions <<----
is_multilib() {
	[[ ${GCCMAJOR} < 3 ]] && return 1
	case ${CTARGET} in
		mips64*|powerpc64*|s390x*|sparc64*|x86_64*)
			has_multilib_profile || use multilib ;;
		*)  false ;;
	esac
}

# adapted from toolchain,
# left only basic multilib functionality and cut off mips stuff
create_gnat_env_entry() {
	dodir /etc/env.d/gnat
	local gnat_envd_base="/etc/env.d/gnat/${CTARGET}-${PN}-${SLOT}"

	gnat_envd_file="${D}${gnat_envd_base}"
#	gnat_specs_file=""

	echo "PATH=\"${BINPATH}:${LIBEXECPATH}\"" > ${gnat_envd_file}

	LDPATH="${LIBPATH}"
	for path in 32 64 o32 ; do
		[[ -d ${LIBPATH}/${path} ]] && LDPATH="${LDPATH}:${LIBPATH}/${path}"
	done
	echo "LDPATH=\"${LDPATH}\"" >> ${gnat_envd_file}

	echo "MANPATH=\"${DATAPATH}/man\"" >> ${gnat_envd_file}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${gnat_envd_file}

	is_crosscompile && echo "CTARGET=${CTARGET}" >> ${gnat_envd_file}

	# Set which specs file to use
#	[[ -n ${gnat_specs_file} ]] && echo "GCC_SPECS=\"${gnat_specs_file}\"" >> ${gnat_envd_file}
}

# eselect stuff taken straight from toolchain.eclass and greatly simplified
add_profile_eselect_conf() {
	local gnat_config_file=$1
	local abi=$2
	local var

	echo >> ${gnat_config_file}
	if ! is_multilib ; then
		echo "  ctarget=${CTARGET}" >> ${gnat_config_file}
	else
		echo "[${abi}]" >> ${gnat_config_file}
		var="CTARGET_${abi}"
		if [[ -n ${!var} ]] ; then
			echo "  ctarget=${!var}" >> ${gnat_config_file}
		else
			var="CHOST_${abi}"
			if [[ -n ${!var} ]] ; then
				echo "  ctarget=${!var}" >> ${gnat_config_file}
			else
				echo "  ctarget=${CTARGET}" >> ${gnat_config_file}
			fi
		fi
	fi

	var="CFLAGS_${abi}"
	if [[ -n ${!var} ]] ; then
		echo "  cflags=${!var}" >> ${gnat_config_file}
	fi
}


create_eselect_conf() {
	# it would be good to source gnat.eselect module here too,
	# but we only need one path
	local config_dir="/usr/share/gnat/eselect"
	local gnat_config_file="${D}/${config_dir}/${CTARGET}-${PN}-${SLOT}"
	local abi

	dodir ${config_dir}

	echo "[global]" > ${gnat_config_file}
	echo "  version=${CTARGET}-${SLOT}" >> ${gnat_config_file}
	echo "  binpath=${BINPATH}" >> ${gnat_config_file}
	echo "  libexecpath=${LIBEXECPATH}" >> ${gnat_config_file}
	echo "  ldpath=${LIBPATH}" >> ${gnat_config_file}
	echo "  manpath=${DATAPATH}/man" >> ${gnat_config_file}
	echo "  infopath=${DATAPATH}/info" >> ${gnat_config_file}
#     echo "  alias_cc=gcc" >> ${compiler_config_file}
#     echo "  stdcxx_incdir=${STDCXX_INCDIR##*/}" >> ${compiler_config_file}
	echo "  bin_prefix=${CTARGET}" >> ${gnat_config_file}

	for abi in $(get_all_abis) ; do
		add_profile_eselect_conf "${gnat_config_file}" "${abi}"
	done
}


# active compiler selection, called from pkg_postinst
do_gnat_config() {
	eselect gnat set ${CTARGET}-${PN}-${SLOT} &> /dev/null

	einfo "The following gnat profile has been activated:"
	einfo "${CTARGET}-${PN}-${SLOT}"
	einfo ""
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
}

#---->> pkg_* <<----
gnatbuild_pkg_setup() {
	debug-print-function ${FUNCNAME} $@

	# Setup variables which would normally be in the profile
	if is_crosscompile ; then
		multilib_env ${CTARGET}
		if ! use multilib ; then
			MULTILIB_ABIS=${DEFAULT_ABI}
		fi
	fi

	# we dont want to use the installed compiler's specs to build gnat!
	unset GCC_SPECS
}

gnatbuild_pkg_postinst() {
	do_gnat_config
}

# eselect-gnat can be unmerged together with gnat-*, so we better do this before
# actual removal takes place, rather than in postrm, like toolchain does
gnatbuild_pkg_prerm() {
	# files for eselect module are left behind, so we need to cleanup.
	if [ ! -f /usr/share/eselect/modules/gnat.eselect ] ; then
		eerror "eselect-gnat was prematurely unmerged!"
		eerror "You will have to manually remove unnecessary files"
		eerror "under /etc/eselect/gnat and /etc/env.d/55gnat-xxx"
		exit # should *not* die, as this will stop unmerge!
	fi

	# this copying/modifying and then sourcing of a gnat.eselect is a hack,
	# but having a duplicate functionality is really bad - gnat.eselect module
	# might change..
	cat /usr/share/eselect/modules/gnat.eselect | \
		grep -v "svn_date_to_version" | \
		grep -v "DESCRIPTION" \
		> ${WORKDIR}/gnat.esel
	. ${WORKDIR}/gnat.esel

	# see if we need to unset gnat
	if [[ $(get_current_gnat) == "${CTARGET}-${PN}-${SLOT}" ]] ; then
		eselect gnat unset &> /dev/null
	fi
}
#---->> pkg_* <<----

#---->> src_* <<----

# common unpack stuff
gnatbuild_src_unpack() {
	debug-print-function ${FUNCNAME} $@
	[ -z "$1" ] &&  gnatbuild_src_unpack all

	while [ "$1" ]; do
	case $1 in
		base_unpack)
			unpack ${A}
		;;

		common_prep)
			# Prepare the gcc source directory
			if [ "2.8.1" == "${GCCVER}" ] ; then
				cd "${S}"
			else
				cd "${S}/gcc"
			fi
			touch cstamp-h.in
			touch ada/[es]info.h
			touch ada/nmake.ad[bs]
			# set the compiler name to gnatgcc
			for i in `find ada/ -name '*.ad[sb]'`; do \
				sed -i -e "s/\"gcc\"/\"gnatgcc\"/g" ${i}; \
			done
			# add -fPIC flag to shared libs
			cd ada
			patch Make-lang.in < ${FILESDIR}/gnat-Make-lang.in.patch

			mkdir -p "${GNATBUILD}"
		;;

		all)
			gnatbuild_src_unpack base_unpack common_prep
		;;
	esac
	shift
	done
}

# it would be nice to split configure and make steps
# but both need to operate inside specially tuned evironment
# so just do sections for now (as in eclass section of handbook)
# sections are: configure, make-tools, bootstrap,
#  gnatlib_and_tools, gnatlib-shared
gnatbuild_src_compile() {
	debug-print-function ${FUNCNAME} $@
	if [[ -z "$1" ]]; then
		gnatbuild_src_compile all
		return $?
	fi

	if [ "all" == "$1" ]
	then # specialcasing "all" to avoid scanning sources unnecessarily
		gnatbuild_src_compile configure make-tools \
			bootstrap gnatlib_and_tools gnatlib-shared

	else
		# Set some paths to our bootstrap compiler.
		export PATH="${GNATBOOT}/bin:${PATH}"
		if [ "${PN_GnatPro}-3.15p" == "${P}" ]; then
			GNATLIB="${GNATBOOT}/lib/gcc-lib/${CTARGET}/${SLOT}"
		else
			GNATLIB="${GNATBOOT}/lib/gnatgcc/${CTARGET}/${SLOT}"
		fi

		export CC="${GNATBOOT}/bin/gnatgcc"

		export ADA_OBJECTS_PATH="${GNATLIB}/adalib"
		export ADA_INCLUDE_PATH="${GNATLIB}/adainclude"
		export LDFLAGS="-L${GNATLIB}"

#		if [ "2.8.1" == ${GCCVER} ]; then
#			export BINUTILS_ROOT="${GNATBOOT}"
#		fi

		#einfo "CC=${CC},  ADA_INCLUDE_PATH=${ADA_INCLUDE_PATH},	LDFLAGS=${LDFLAGS}"

		while [ "$1" ]; do
		case $1 in
			configure)
				debug-print-section configure
				# Configure gcc
				local confgcc

				# some cross-compile logic from toolchain
				confgcc="${confgcc} --host=${CHOST}"
				if is_crosscompile || tc-is-cross-compiler ; then
					confgcc="${confgcc} --target=${CTARGET}"
				fi
				[[ -n ${CBUILD} ]] && confgcc="${confgcc} --build=${CBUILD}"

				# Native Language Support
				if use nls ; then
					confgcc="${confgcc} --enable-nls --without-included-gettext"
				else
					confgcc="${confgcc} --disable-nls"
				fi

				# reasonably sane globals (from toolchain)
				confgcc="${confgcc} \
					--with-system-zlib \
					--disable-checking \
					--disable-werror \
					--disable-libunwind-exceptions"

				cd "${GNATBUILD}"
				CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" "${S}"/configure \
					--prefix=${PREFIX} \
					--bindir=${BINPATH} \
					--includedir=${INCLUDEPATH} \
					--libdir="${LIBPATH}" \
					--libexecdir="${LIBEXECPATH}" \
					--datadir=${DATAPATH} \
					--mandir=${DATAPATH}/man \
					--infodir=${DATAPATH}/info \
					--program-prefix=gnat \
					--enable-languages="c,ada" \
					--enable-libada \
					--with-gcc \
					--enable-threads=posix \
					--enable-shared \
					--with-system-zlib \
					--disable-nls \
					${confgcc} || die "configure failed"
			;;

			make-tools)
				debug-print-section make-tools
				# Compile helper tools
				cd "${GNATBOOT}"
				cp ${S}/gcc/ada/xtreeprs.adb .
				cp ${S}/gcc/ada/xsinfo.adb .
				cp ${S}/gcc/ada/xeinfo.adb .
				cp ${S}/gcc/ada/xnmake.adb .
				gnatmake xtreeprs && \
					gnatmake xsinfo && \
					gnatmake xeinfo && \
					gnatmake xnmake || die "building helper tools"
			;;

			bootstrap)
				debug-print-section bootstrap
				# and, finally, the build itself
				cd "${GNATBUILD}"
				emake bootstrap || die "bootstrap failed"
			;;

			gnatlib_and_tools)
				debug-print-section gnatlib_and_tools
				einfo "building gnatlib_and_tools"
				cd "${GNATBUILD}"
				emake -j1 -C gcc gnatlib_and_tools || \
					die "gnatlib_and_tools failed"
			;;

			gnatlib-shared)
				debug-print-section gnatlib-shared
				einfo "building shared lib"
				cd "${GNATBUILD}"
				rm -f gcc/ada/rts/*.{o,ali} || die
				#otherwise make tries to reuse already compiled (without -fPIC) objs..
				emake -j1 -C gcc gnatlib-shared LIBRARY_VERSION="${GCCBRANCH}" || \
					die "gnatlib-shared failed"
			;;
		esac
		shift
		done # while
	fi   # "all" == "$1"
}


gnatbuild_src_install() {
	debug-print-function ${FUNCNAME} $@

	if [[ -z "$1" ]] ; then
		gnatbuild_src_install all
		return $?
	fi

	while [ "$1" ]; do
	case $1 in
	install) # runs provided make install
		debug-print-section install
		# Do not allow symlinks in /usr/lib/gcc/${CHOST}/${MY_PV}/include as
		# this can break the build.
		for x in "${GNATBUILD}"/gcc/include/* ; do
			if [ -L ${x} ] ; then
				rm -f ${x}
			fi
		done
		# Remove generated headers, as they can cause things to break
		# (ncurses, openssl, etc). (from toolchain.eclass)
		for x in $(find "${WORKDIR}"/build/gcc/include/ -name '*.h') ; do
			grep -q 'It has been auto-edited by fixincludes from' "${x}" \
				&& rm -f "${x}"
		done


		# Install gnatgcc, tools and native threads library
		cd "${GNATBUILD}"
		if [ "${PN_GnatGpl}-3.4.5.1" != "${P}" ]; then # this one is strange
			make DESTDIR=${D} install || die
			#make a convenience info link
			dosym ${DATAPATH}/info/gnat_ugn_unw.info ${DATAPATH}/info/gnat.info
		fi
		;;

	move_libs)
		debug-print-section move_libs
		# gcc insists on installing libs in its own place
		mv "${D}${LIBPATH}/gcc/${CTARGET}/${GCCRELEASE}"/* "${D}${LIBPATH}"
		if [ "${ARCH}" == "amd64" ]; then
			# ATTN! this may in fact be related to multilib, rather than amd64
			mv "${D}${LIBPATH}"/../lib64/libgcc_s* "${D}${LIBPATH}"
			mv "${D}${LIBPATH}"/../lib/libgcc_s* "${D}${LIBPATH}"/32/
		fi
		mv "${D}${LIBEXECPATH}/gcc/${CTARGET}/${GCCRELEASE}"/* "${D}${LIBEXECPATH}"

		# set the rts libs
		cd "${D}${LIBPATH}"
		mkdir rts-native
		mv adalib adainclude rts-native
		ln -s rts-native/adalib adalib
		ln -s rts-native/adainclude adainclude

		# force gnatgcc to use its own specs - when installed it reads specs
		# from system gcc location. Do the simple wrapper trick for now
		# !ATTN! change this if eselect-gnat starts to follow eselect-compiler
		cd "${D}${BINPATH}"
		mv gnatgcc gnatgcc_2wrap
		cat > gnatgcc << EOF
#! /bin/bash
# wrapper to cause gnatgcc read appropriate specs
BINDIR=\$(dirname \$0)
\${BINDIR}/gnatgcc_2wrap -specs="${LIBPATH}/specs" \$@
EOF
		chmod a+x gnatgcc

		# use gid of 0 because some stupid ports don't have
		# the group 'root' set to gid 0 (toolchain.eclass)
		chown -R root:0 "${D}${LIBPATH}"
		;;

	cleanup)
		debug-print-section cleanup

		rm -rf "${D}${LIBPATH}"/../li{b,b64}
		rm -rf "${D}${LIBPATH}/gcc"
		rm -rf "${D}${LIBEXECPATH}/gcc"
		rm -f "${D}${LIBPATH}"/libiberty.a # this one comes with binutils
		rmdir "${D}${LIBPATH}"/include/    # should be empty

		rm -rf "${D}${LIBEXECPATH}"/install-tools/

		# this one is installed by gcc and is a duplicate even here anyway
		rm -f "${D}${BINPATH}/${CTARGET}-gcc-${GCCRELEASE}"

		# remove duplicate docs
		cd "${D}${DATAPATH}"
		has noinfo ${FEATURES} \
			&& rm -rf info \
			|| rm -f info/{dir,gcc,cpp}*
		has noman  ${FEATURES} \
			&& rm -rf man \
			|| rm -rf man/man7/
		;;

	prep_env)
		#dodir /etc/env.d/gnat
		#create_gnat_env_entry
		# instead of putting junk under /etc/env.d/gnat we recreate env files as
		# needed with eselect
		create_eselect_conf
		;;

	all)
		gnatbuild_src_install install move_libs cleanup prep_env
		;;
	esac
	shift
	done # while
}
