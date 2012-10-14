# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/python-r1.eclass,v 1.1 2012/10/14 10:51:28 mgorny Exp $

# @ECLASS: python-r1
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# Python herd <python@gentoo.org>
# @AUTHOR:
# Author: Michał Górny <mgorny@gentoo.org>
# Based on work of: Krzysztof Pawlik <nelchael@gentoo.org>
# @BLURB: A common, simple eclass for Python packages.
# @DESCRIPTION:
# A common eclass providing helper functions to build and install
# packages supporting being installed for multiple Python
# implementations.
#
# This eclass sets correct IUSE and REQUIRED_USE. It exports PYTHON_DEPS
# and PYTHON_USEDEP so you can create correct dependencies for your
# package easily. It also provides methods to easily run a command for
# each enabled Python implementation and duplicate the sources for them.

case "${EAPI}" in
	0|1|2|3)
		die "Unsupported EAPI=${EAPI} (too old) for ${ECLASS}"
		;;
	4)
		# EAPI=4 needed for REQUIRED_USE
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

# @ECLASS-VARIABLE: _PYTHON_ALL_IMPLS
# @INTERNAL
# @DESCRIPTION:
# All supported Python implementations, most preferred last.
_PYTHON_ALL_IMPLS=(
	jython2_5
	pypy1_8 pypy1_9
	python3_1 python3_2
	python2_5 python2_6 python2_7
)

# @ECLASS-VARIABLE: PYTHON_COMPAT
# @DESCRIPTION:
# This variable contains a list of Python implementations the package
# supports. It must be set before the `inherit' call.  The default is to
# enable all implementations. It has to be an array.
if ! declare -p PYTHON_COMPAT &>/dev/null; then
	PYTHON_COMPAT=( "${_PYTHON_ALL_IMPLS[@]}" )
fi

# @ECLASS-VARIABLE: PYTHON_REQ_USE
# @DEFAULT_UNSET
# @DESCRIPTION:
# The list of USEflags required to be enabled on the chosen Python
# implementations, formed as a USE-dependency string. It should be valid
# for all implementations in PYTHON_COMPAT, so it may be necessary to
# use USE defaults.
#
# Example:
# @CODE
# PYTHON_REQ_USE="gdbm,ncurses(-)?"
# @CODE
#
# Will cause the Python dependencies to look like:
# @CODE
# python_targets_pythonX_Y? (
#   dev-lang/python:X_Y[gdbm,ncurses(-)?] )
# @CODE

# @ECLASS-VARIABLE: PYTHON_DEPS
# @DESCRIPTION:
# This is an eclass-generated Python dependency string for all
# implementations listed in PYTHON_COMPAT. It should be used
# in RDEPEND and/or DEPEND like:
#
# @CODE
# RDEPEND="${PYTHON_DEPS}
#   dev-foo/mydep"
# DEPEND="${RDEPEND}"
# @CODE

# @ECLASS-VARIABLE: PYTHON_USEDEP
# @DESCRIPTION:
# This is an eclass-generated USE-dependency string which can be used to
# depend on another Python package being built for the same Python
# implementations. It should be used like:
#
# @CODE
# RDEPEND="dev-python/foo[${PYTHON_USEDEP}]"
# @CODE

_python_set_globals() {
	local flags=( "${PYTHON_COMPAT[@]/#/python_targets_}" )
	local optflags=${flags[@]/%/?}

	IUSE=${flags[*]}
	REQUIRED_USE="|| ( ${flags[*]} )"
	PYTHON_USEDEP=${optflags// /,}

	PYTHON_DEPS=
	local i
	for i in "${PYTHON_COMPAT[@]}"; do
		local d
		case ${i} in
			python*)
				d='dev-lang/python';;
			jython*)
				d='dev-java/jython';;
			pypy*)
				d='dev-python/pypy';;
			*)
				die "Invalid implementation: ${i}"
		esac

		local v=${i##*[a-z]}
		local usestr
		[[ ${PYTHON_REQ_USE} ]] && usestr="[${PYTHON_REQ_USE}]"
		PYTHON_DEPS+=" python_targets_${i}? (
			${d}:${v/_/.}${usestr} )"
	done
}
_python_set_globals

# @FUNCTION: _python_set_PYTHON
# @USAGE: <impl>
# @INTERNAL
# @DESCRIPTION:
# Get the Python executable name for the given implementation and set it
# as ${PYTHON} & ${EPYTHON}. Please note that EPYTHON will contain
# the 'basename' while PYTHON will contain the full path.
_python_set_PYTHON() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl=${1/_/.}

	case "${impl}" in
		python*|jython*)
			EPYTHON=${impl}
			;;
		pypy*)
			EPYTHON=pypy-c${impl#pypy}
			;;
		*)
			die "Invalid argument to _python_set_PYTHON: ${1}"
			;;
	esac
	PYTHON=${EPREFIX}/usr/bin/${EPYTHON}

	debug-print "${FUNCNAME}: ${impl} -> ${PYTHON}"
}

# @FUNCTION: python_copy_sources
# @DESCRIPTION:
# Create a single copy of the package sources (${S}) for each enabled
# Python implementation.
python_copy_sources() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl
	local bdir=${BUILD_DIR:-${S}}

	debug-print "${FUNCNAME}: bdir = ${bdir}"
	einfo "Will copy sources from ${S}"
	# the order is irrelevant here
	for impl in "${PYTHON_COMPAT[@]}"; do
		if use "python_targets_${impl}"
		then
			local BUILD_DIR=${bdir%%/}-${impl}

			einfo "${impl}: copying to ${BUILD_DIR}"
			debug-print "${FUNCNAME}: [${impl}] cp ${S} => ${BUILD_DIR}"
			cp -pr "${S}" "${BUILD_DIR}" || die
		fi
	done
}

# @FUNCTION: python_foreach_impl
# @USAGE: <command> [<args>...]
# @DESCRIPTION:
# Run the given command for each of the enabled Python implementations.
# If additional parameters are passed, they will be passed through
# to the command. If the command fails, python_foreach_impl dies.
# If necessary, use ':' to force a successful return.
#
# Before the command is run, EPYTHON is set to the name of the current
# Python implementation, PYTHON is set to the correct Python executable
# name and exported, and BUILD_DIR is set to a 'default' build directory
# for given implementation (e.g. ${BUILD_DIR:-${S}}-python2_7).
#
# The command is run inside the build directory. If it doesn't exist
# yet, it is created (as an empty directory!). If your build system does
# not support out-of-source builds, you will likely want to use
# python_copy_sources first.
python_foreach_impl() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl
	local bdir=${BUILD_DIR:-${S}}

	debug-print "${FUNCNAME}: bdir = ${bdir}"
	for impl in "${_PYTHON_ALL_IMPLS[@]}"; do
		if has "${impl}" "${PYTHON_COMPAT[@]}" && use "python_targets_${impl}"
		then
			local EPYTHON PYTHON
			_python_set_PYTHON "${impl}"
			local BUILD_DIR=${bdir%%/}-${impl}
			export PYTHON

			debug-print "${FUNCNAME}: [${impl}] build_dir = ${BUILD_DIR}"

			mkdir -p "${BUILD_DIR}" || die
			pushd "${BUILD_DIR}" &>/dev/null || die
			einfo "${EPYTHON}: running ${@}"
			"${@}" || die "${EPYTHON}: ${1} failed"
			popd &>/dev/null || die
		fi
	done
}
