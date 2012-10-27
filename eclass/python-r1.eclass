# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/python-r1.eclass,v 1.7 2012/10/27 01:14:38 floppym Exp $

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
#
# Please note that this eclass is mostly intended to be extended
# on-request. If you find something you used in other eclasses missing,
# please don't hack it around and request an enhancement instead.

case "${EAPI}" in
	0|1|2|3)
		die "Unsupported EAPI=${EAPI} (too old) for ${ECLASS}"
		;;
	4|5)
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
# supports. It must be set before the `inherit' call. It has to be
# an array.
#
# The default is to enable all supported implementations. However, it is
# discouraged to use that default unless in very special cases and test
# the package with each added implementation instead.
#
# Example:
# @CODE
# PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
# @CODE
#
# Please note that you can also use bash brace expansion if you like:
# @CODE
# PYTHON_COMPAT=( python{2_5,2_6,2_7} )
# @CODE
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
# It will cause the Python dependencies to look like:
# @CODE
# python_targets_pythonX_Y? (
#   dev-lang/python:X_Y[gdbm,ncurses(-)?] )
# @CODE

# @ECLASS-VARIABLE: PYTHON_DEPS
# @DESCRIPTION:
# This is an eclass-generated Python dependency string for all
# implementations listed in PYTHON_COMPAT.
#
# Example use:
# @CODE
# RDEPEND="${PYTHON_DEPS}
#   dev-foo/mydep"
# DEPEND="${RDEPEND}"
# @CODE
#
# Example value:
# @CODE
# python_targets2_6? ( dev-lang/python:2.6[gdbm] )
# python_targets2_7? ( dev-lang/python:2.7[gdbm] )
# @CODE

# @ECLASS-VARIABLE: PYTHON_USEDEP
# @DESCRIPTION:
# This is an eclass-generated USE-dependency string which can be used to
# depend on another Python package being built for the same Python
# implementations.
#
# The generate USE-flag list is compatible with packages using python-r1
# and python-distutils-ng eclasses. It must not be used on packages
# using python.eclass.
#
# Example use:
# @CODE
# RDEPEND="dev-python/foo[${PYTHON_USEDEP}]"
# @CODE
#
# Example value:
# @CODE
# python_targets_python2_6?,python_targets_python2_7?
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

# @ECLASS-VARIABLE: BUILD_DIR
# @DESCRIPTION:
# The current build directory. In global scope, it is supposed to
# contain an initial build directory; if unset, it defaults to ${S}.
#
# In functions run by python_foreach_impl(), the BUILD_DIR is locally
# set to an implementation-specific build directory. That path is
# created through appending a hyphen and the implementation name
# to the final component of the initial BUILD_DIR.
#
# Example value:
# @CODE
# ${WORKDIR}/foo-1.3-python2_6
# @CODE

# @ECLASS-VARIABLE: PYTHON
# @DESCRIPTION:
# The absolute path to the current Python interpreter.
#
# Set and exported only in commands run by python_foreach_impl().
#
# Example value:
# @CODE
# /usr/bin/python2.6
# @CODE

# @ECLASS-VARIABLE: EPYTHON
# @DESCRIPTION:
# The executable name of the current Python interpreter.
#
# This variable is used consistently with python.eclass.
#
# Set and exported only in commands run by python_foreach_impl().
#
# Example value:
# @CODE
# python2.6
# @CODE

# @FUNCTION: python_export
# @USAGE: [<impl>] <variables>...
# @DESCRIPTION:
# Set and export the Python implementation-relevant variables passed
# as parameters.
#
# The optional first parameter may specify the requested Python
# implementation (either as PYTHON_TARGETS value, e.g. python2_7,
# or an EPYTHON one, e.g. python2.7). If no implementation passed,
# the current one will be obtained from ${EPYTHON}.
#
# The variables which can be exported are: PYTHON, EPYTHON. They are
# described more completely in the eclass variable documentation.
python_export() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl var

	case "${1}" in
		python*|jython*)
			impl=${1/_/.}
			shift
			;;
		pypy-c*)
			impl=${1}
			shift
			;;
		pypy*)
			local v=${1#pypy}
			impl=pypy-c${v/_/.}
			shift
			;;
		*)
			impl=${EPYTHON}
			[[ ${impl} ]] || die "python_export: no impl nor EPYTHON"
			;;
	esac
	debug-print "${FUNCNAME}: implementation: ${impl}"

	for var; do
		case "${var}" in
			EPYTHON)
				export EPYTHON=${impl}
				debug-print "${FUNCNAME}: EPYTHON = ${EPYTHON}"
				;;
			PYTHON)
				export PYTHON=${EPREFIX}/usr/bin/${impl}
				debug-print "${FUNCNAME}: PYTHON = ${PYTHON}"
				;;
			*)
				die "python_export: unknown variable ${var}"
		esac
	done
}

# @FUNCTION: python_copy_sources
# @DESCRIPTION:
# Create a single copy of the package sources (${S}) for each enabled
# Python implementation.
#
# The sources are always copied from S to implementation-specific build
# directories respecting BUILD_DIR.
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
# For each command being run, EPYTHON, PYTHON and BUILD_DIR are set
# locally, and the former two are exported to the command environment.
python_foreach_impl() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl
	local bdir=${BUILD_DIR:-${S}}

	debug-print "${FUNCNAME}: bdir = ${bdir}"
	for impl in "${_PYTHON_ALL_IMPLS[@]}"; do
		if has "${impl}" "${PYTHON_COMPAT[@]}" && use "python_targets_${impl}"
		then
			local EPYTHON PYTHON
			python_export "${impl}" EPYTHON PYTHON
			local BUILD_DIR=${bdir%%/}-${impl}
			export EPYTHON PYTHON

			einfo "${EPYTHON}: running ${@}"
			"${@}" || die "${EPYTHON}: ${1} failed"
		fi
	done
}
