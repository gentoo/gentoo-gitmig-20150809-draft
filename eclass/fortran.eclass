# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fortran.eclass,v 1.1 2004/10/01 12:08:16 kugelfang Exp $
#
# Author: Danny van Dyk <kugelfang@gentoo.org>
#

ECLASS=fortran
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

# need_fortran(<profiles>):
#  profiles = <profile> ... <profile>
#  profile = [path/to/]<compiler>
#
#  compiler:
#   * f77 - GCC Fortran 77
#   * f2c - Fortran 2 C Translator
#   * ifc - Intel Fortran Compiler
#
# Checks if at least one of <profiles> is installed.
# Checks also if F77 (the fortran compiler to use) is available
# on the System.
need_fortran() {
	if [ -z "$@" ]; then
		eerror "Call need_fortran with at least one argument !"
	fi 
	local AVAILABLE=""
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
		einfo "Installed are:${AVAILABLE}"
		if [ -n "${F77}" ]; then
			MY_F77="$(basename ${F77})"
			case ${MY_F77} in
				g77)
					TEST="${AVAILABLE:-f77}"
					;;
				ifc|f2c)
					TEST="${AVAILABLE:-${MY_F77}}"
			esac
			if [ "${TEST}" == "${AVAILABLE}" ]; then
				warn "F77 is set to ${F77}, which is not available \
					on this System !"
				F77=${AVAILABLE##\ *}
			fi
		fi
	fi
}

# patch_fortran():
#  Apply necessary patches for ${F77}
patch_fortran() {
	PATCHES=${FILESDIR}/${P}-$(basename ${F77})*
	if [ -n "${PATCHES}" ]; then
		for PATCH in ${PATCHES}; do
			epatch ${PATCH}
		done
	fi
}

# fortran_pkg_setup():
#  Set FORTRAN to indicate the list of Fortran Compiler that
#  can be used for the ebuild.
#  If not set in ebuild, FORTRAN will default to:
FORTRAN="f77"
fortran_pkg_setup() {
	need_fortran ${FORTRAN}
}

# fortran_src_unpack():
#  Run patch_fortran if no new src_unpack() is defined.
fortran_src_unpack() {
	unpack ${A}
	cd ${S}
	patch_fortran
}

EXPORT_FUNCTIONS pkg_setup src_unpack
