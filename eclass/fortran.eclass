# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fortran.eclass,v 1.9 2005/07/11 15:08:06 swegener Exp $
#
# Author: Danny van Dyk <kugelfang@gentoo.org>
#

inherit eutils

DESCRIPTION="Based on the ${ECLASS} eclass"

IUSE="debug"

#DEPEND="virtual/fortran" # Let's aim for this...

# Which Fortran Compiler has been selected ?
export FORTRANC

# These are the options to ./configure / econf that enable the usage
# of a specific Fortran Compiler. If your package uses a different
# option that the one listed here, overwrite it in your ebuild.
g77_CONF="--with-f77"
f2c_CONF="--with-f2c"

# This function prints the necessary options for the currently selected
# Fortran Compiler.
fortran_conf() {
	echo $(eval echo \${$(echo -n ${FORTRANC})_CONF})
}

# need_fortran(<profiles>):
#  profiles = <profile> ... <profile>
#
#  profile:
#   * g77 - GCC Fortran 77
#   * f2c - Fortran 2 C Translator
#   * ifc - Intel Fortran Compiler
#
# Checks if at least one of <profiles> is installed.
# Checks also if F77 (the fortran compiler to use) is available
# on the System.
need_fortran() {
	if [ -z "$*" ]; then
		eerror "Call need_fortran with at least one argument !"
	fi
	local AVAILABLE
	local PROFILE
	for PROFILE in $@; do
		case ${PROFILE} in
			g77)
				if [ -x "$(which g77 2> /dev/null)" ]; then
					AVAILABLE="${AVAILABLE} g77"
				fi
				;;
			f2c)
				if [ -x "$(which f2c 2> /dev/null)" ]; then
					AVAILABLE="${AVAILABLE} f2c"
				fi
				;;
			ifc)
				case ${ARCH} in
					x86|ia64)
						if [ -x "$(which if2 2> /dev/null)" ]; then
							AVAILABLE="${AVAILABLE} ifc"
						fi
						;;
					*)
						;;
				esac
				;;
		esac
	done
	AVAILABLE="${AVAILABLE/^[[:space:]]}"
	use debug && echo ${AVAILABLE}
	if [ -z "${AVAILABLE}" ]; then
		eerror "None of the needed Fortran Compilers ($@) is installed."
		eerror "To install one of these, choose one of the following steps:"
		i=1
		for PROFILE in $@; do
			case ${PROFILE} in
				g77)
					eerror "[${i}] USE=\"fortran\" emerge sys-devel/gcc"
					;;
				f2c)
					eerror "[${i}] emerge dev-lang/f2c"
					;;
				ifc)
					case ${ARCH} in
						x86|ia64)
							eerror "[${i}] emerge dev-lang/ifc"
							;;
						*)
							;;
					esac
			esac
			i=$((i + 1))
		done
		die "Install a Fortran Compiler !"
	else
		einfo "You need one of these Fortran Compilers: $@"
		einfo "Installed are: ${AVAILABLE}"
		if [ -n "${F77}" -o -n "${FC}" -o -n "${F2C}" ]; then
			if [ -n "${F77}" ]; then
				FC="${F77}"						# F77 overwrites FC
			fi
			if [ -n "${FC}" -a -n "${F2C}" ]; then
				ewarn "Using ${FC} and f2c is impossible. Disabling f2c !"
				F2C=""							# Disabling f2c
				MY_FORTRAN="$(basename ${FC})"	# set MY_FORTRAN to filename of
												# the Fortran Compiler
			elif [ -n "${F2C}" ]; then
				MY_FORTRAN="$(basename ${F2C})"
			fi
		fi

		# default to g77
		use debug && echo "MY_FORTRAN: \"${MY_FORTRAN}\""
		MY_FORTRAN=${MY_FORTRAN:=g77}
		use debug && echo "MY_FORTRAN: \"${MY_FORTRAN}\""

		if ! hasq ${MY_FORTRAN} ${AVAILABLE}; then
			eerror "Current Fortran Compiler is set to ${MY_FORTRAN}, which is not usable with this package !"
			die "Wrong Fortran Compiler !"
		fi

		case ${MY_FORTRAN} in
			g77|ifc|f2c)
				FORTRANC="${MY_FORTRAN}"
		esac
	fi
	use debug && echo "FORTRANC: \"${FORTRANC}\""
}

# patch_fortran():
#  Apply necessary patches for ${FORTRANC}
patch_fortran() {
	if [ -z "${FORTRANC}" ]; then
		return
	fi
	local PATCHES=$(find ${FILESDIR}/ -name "${P}-${FORTRANC}*")
#local PATCHES=${FILESDIR}/${P}-${FORTRANC}*
	local PATCH
	if [ -n "${PATCHES}" ]; then
		for PATCH in ${PATCHES}; do
			epatch ${PATCH}
		done
	fi
}

# fortran_pkg_setup():
#  Set FORTRAN to indicate the list of Fortran Compiler that
#  can be used for the ebuild.
#  If not set in ebuild, FORTRAN will default to f77
fortran_pkg_setup() {
	need_fortran ${FORTRAN:=g77}
}

# fortran_src_unpack():
#  Run patch_fortran if no new src_unpack() is defined.
fortran_src_unpack() {
	unpack ${A}
	cd ${S}
	patch_fortran
}

EXPORT_FUNCTIONS pkg_setup src_unpack
