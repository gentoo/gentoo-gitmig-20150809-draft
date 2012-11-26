# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/python-single-r1.eclass,v 1.4 2012/11/26 10:05:11 mgorny Exp $

# @ECLASS: python-single-r1
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# Python herd <python@gentoo.org>
# @AUTHOR:
# Author: Michał Górny <mgorny@gentoo.org>
# Based on work of: Krzysztof Pawlik <nelchael@gentoo.org>
# @BLURB: An eclass for Python packages not installed for multiple implementations.
# @DESCRIPTION:
# An extension of the python-r1 eclass suite for packages which
# don't support being installed for multiple Python implementations.
# This mostly includes tools embedding Python.
#
# This eclass extends the IUSE and REQUIRED_USE set by python-r1
# to request correct PYTHON_SINGLE_TARGET. It also replaces
# PYTHON_USEDEP and PYTHON_DEPS with a more suitable form.
#
# Please note that packages support multiple Python implementations
# (using python-r1 eclass) can not depend on packages not supporting
# them (using this eclass).
#
# Also, please note that python-single-r1 will always inherit python-r1
# as well. Thus, all the variables defined there are relevant
# to the packages using python-single-r1.
#
# For more information, please see the python-r1 Developer's Guide:
# http://www.gentoo.org/proj/en/Python/python-r1/dev-guide.xml

case "${EAPI:-0}" in
	0|1|2|3)
		die "Unsupported EAPI=${EAPI:-0} (too old) for ${ECLASS}"
		;;
	4|5)
		# EAPI=4 needed by python-r1
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

if [[ ! ${_PYTHON_SINGLE_R1} ]]; then

inherit python-r1

fi

EXPORT_FUNCTIONS pkg_setup

if [[ ! ${_PYTHON_SINGLE_R1} ]]; then

_python_single_set_globals() {
	local flags=( "${PYTHON_COMPAT[@]/#/python_single_target_}" )
	local optflags=${flags[@]/%/(+)?}

	IUSE=${flags[*]}
	REQUIRED_USE="^^ ( ${flags[*]} )"
	PYTHON_USEDEP+=,${optflags// /,}

	local usestr
	[[ ${PYTHON_REQ_USE} ]] && usestr="[${PYTHON_REQ_USE}]"

	# 1) well, python-exec would suffice as an RDEP
	# but no point in making this overcomplex, BDEP doesn't hurt anyone
	# 2) python-exec should be built with all targets forced anyway
	# but if new targets were added, we may need to force a rebuild
	PYTHON_DEPS="dev-python/python-exec[${PYTHON_USEDEP}]"
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
		PYTHON_DEPS+=" python_single_target_${i}? ( ${d}:${v/_/.}${usestr} )"
	done
}
_python_single_set_globals

python-single-r1_pkg_setup() {
	debug-print-function ${FUNCNAME} "${@}"

	local impl
	for impl in "${_PYTHON_ALL_IMPLS[@]}"; do
		if has "${impl}" "${PYTHON_COMPAT[@]}" \
			&& use "python_single_target_${impl}"
		then
			python_export "${impl}" EPYTHON PYTHON
			break
		fi
	done
}

# Incompatible python-r1 functions.

python_copy_sources() {
	die "${FUNCNAME} must not be used with python-single-r1 eclass."
}

python_foreach_impl() {
	die "${FUNCNAME} must not be used with python-single-r1 eclass."
}

python_export_best() {
	die "${FUNCNAME} must not be used with python-single-r1 eclass."
}

_PYTHON_SINGLE_R1=1
fi
