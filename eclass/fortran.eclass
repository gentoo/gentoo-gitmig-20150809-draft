# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fortran.eclass,v 1.3 2004/10/10 22:28:42 kugelfang Exp $
#
# Author: Danny van Dyk <kugelfang@gentoo.org>
#

inherit eutils

DESCRIPTION="Based on the ${ECLASS} eclass"

#DEPEND="virtual/fortran" # Let's aim for this...

# need_fortran(<profiles>):
#  profiles = <profile> ... <profile>
#
#  profile:
#   * f77 - GCC Fortran 77
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
			f77)
				if [ -x "$(which g77 2> /dev/null)" ]; then
					AVAILABLE="${AVAILABLE} f77"
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
							AVAILABLE="${FORTRAN} ifc"
						fi
						;;
					*)
						;;
				esac
				;;
		esac
	done
	AVAILABLE="${AVAILABLE:1}"
	if [ -z "${AVAILABLE}" ]; then
		eerror "None of the needed Fortran Compilers ($@) is installed."
		eerror "To install one of these, choose one of the following steps:"
		i=1
		for PROFILE in $@; do
			case ${PROFILE} in
				f77)
					eerror "[${i}] USE=\"f77\" emerge sys-devel/gcc"
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
				FC="${F77}" # F77 overwrites FC
			fi
			if [ -n "${FC}" -a -n "${F2C}" ]; then
				ewarn "Using ${FC} and f2c is impossible. Disabling f2c !"
				F2C=""
				MY_FORTRAN="$(basename ${FC})"
				EXTRA_ECONF="${EXTRA_ECONF} --with-f77"
			elif [ -n "${F2C}" ]; then
				MY_FORTRAN="$(basename ${F2C})"
				EXTRA_ECONF="${EXTRA_ECONF} --with-f2c"
			fi
			case ${MY_FORTRAN} in
				g77)
					TEST="${AVAILABLE%f77}"
					FORTRANC="f77"
					;;
				ifc|f2c)
					TEST="${AVAILABLE%${MY_FORTRAN}}"
					FORTRANC="${MY_FORTRAN}"
					;;
			esac
			if [ "${TEST}" == "${AVAILABLE}" ]; then
				eerror "Current Fortan Compiler is set to ${MY_FORTRAN}, which is not usable with this package !"
				die "Wrong Fortran Compiler !"
			fi
		fi
	fi
}

# patch_fortran():
#  Apply necessary patches for ${FORTRANC}
patch_fortran() {
	if [ -z "${FORTRANC}" ]; then
		return
	fi
	local PATCHES=${FILESDIR}/${P}-${FORTRANC}*
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
	need_fortran ${FORTRAN:=f77}
}

# fortran_src_unpack():
#  Run patch_fortran if no new src_unpack() is defined.
fortran_src_unpack() {
	unpack ${A}
	cd ${S}
	patch_fortran
}

EXPORT_FUNCTIONS pkg_setup src_unpack
