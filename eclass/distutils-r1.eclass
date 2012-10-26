# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/distutils-r1.eclass,v 1.8 2012/10/26 21:38:47 mgorny Exp $

# @ECLASS: distutils-r1
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# Python herd <python@gentoo.org>
# @AUTHOR:
# Author: Michał Górny <mgorny@gentoo.org>
# Based on the work of: Krzysztof Pawlik <nelchael@gentoo.org>
# @BLURB: A simple eclass to build Python packages using distutils.
# @DESCRIPTION:
# A simple eclass providing functions to build Python packages using
# the distutils build system. It exports phase functions for all
# the src_* phases. Each of the phases runs two pseudo-phases:
# python_..._all() (e.g. python_prepare_all()) once in ${S}, then
# python_...() (e.g. python_prepare()) for each implementation
# (see: python_foreach_impl() in python-r1).
#
# In distutils-r1_src_prepare(), the 'all' function is run before
# per-implementation ones (because it creates the implementations),
# per-implementation functions are run in a random order.
#
# In remaining phase functions, the per-implementation functions are run
# before the 'all' one, and they are ordered from the least to the most
# preferred implementation (so that 'better' files overwrite 'worse'
# ones).
#
# If the ebuild doesn't specify a particular pseudo-phase function,
# the default one will be used (distutils-r1_...). Defaults are provided
# for all per-implementation pseudo-phases, python_prepare_all()
# and python_install_all(); whenever writing your own pseudo-phase
# functions, you should consider calling the defaults (and especially
# distutils-r1_python_prepare_all).
#
# Please note that distutils-r1 sets RDEPEND and DEPEND unconditionally
# for you.
#
# Also, please note that distutils-r1 will always inherit python-r1
# as well. Thus, all the variables defined and documented there are
# relevant to the packages using distutils-r1.

case "${EAPI}" in
	0|1|2|3)
		die "Unsupported EAPI=${EAPI} (too old) for ${ECLASS}"
		;;
	4|5)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

inherit eutils python-r1

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test src_install

RDEPEND="${PYTHON_DEPS}
	dev-python/python-exec"
DEPEND=${PYTHON_DEPS}

# @ECLASS-VARIABLE: PATCHES
# @DEFAULT_UNSET
# @DESCRIPTION:
# An array containing patches to be applied to the sources before
# copying them.
#
# If unset, no custom patches will be applied.
#
# Please note, however, that at some point the eclass may apply
# additional distutils patches/quirks independently of this variable.
#
# Example:
# @CODE
# PATCHES=( "${FILESDIR}"/${P}-make-gentoo-happy.patch )
# @CODE

# @ECLASS-VARIABLE: DOCS
# @DEFAULT_UNSET
# @DESCRIPTION:
# An array containing documents installed using dodoc. The files listed
# there must exist in the directory from which
# distutils-r1_python_install_all() is run (${S} by default).
#
# If unset, the function will instead look up files matching default
# filename pattern list (from the Package Manager Specification),
# and install those found.
#
# Example:
# @CODE
# DOCS=( NEWS README )
# @CODE

# @ECLASS-VARIABLE: HTML_DOCS
# @DEFAULT_UNSET
# @DESCRIPTION:
# An array containing documents installed using dohtml. The files
# and directories listed there must exist in the directory from which
# distutils-r1_python_install_all() is run (${S} by default).
#
# If unset, no HTML docs will be installed.
#
# Example:
# @CODE
# HTML_DOCS=( doc/html/ )
# @CODE

# @FUNCTION: distutils-r1_python_prepare_all
# @DESCRIPTION:
# The default python_prepare_all(). It applies the patches from PATCHES
# array, then user patches and finally calls python_copy_sources to
# create copies of resulting sources for each Python implementation.
#
# At some point in the future, it may also apply eclass-specific
# distutils patches and/or quirks.
distutils-r1_python_prepare_all() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ ${PATCHES} ]] && epatch "${PATCHES[@]}"

	epatch_user

	# create source copies for each implementation
	python_copy_sources
}

# @FUNCTION: distutils-r1_python_prepare
# @DESCRIPTION:
# The default python_prepare(). Currently it is a no-op
# but in the future it may apply implementation-specific quirks
# to the build system.
distutils-r1_python_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	:
}

# @FUNCTION: distutils-r1_python_configure
# @DESCRIPTION:
# The default python_configure(). Currently a no-op.
distutils-r1_python_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	:
}

# @FUNCTION: distutils-r1_python_compile
# @USAGE: [additional-args...]
# @DESCRIPTION:
# The default python_compile(). Runs 'setup.py build' using the correct
# Python implementation. Any parameters passed to this function will be
# passed to setup.py.
distutils-r1_python_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	cd "${BUILD_DIR}" || die
	set -- "${PYTHON}" setup.py build "${@}"
	echo "${@}"
	"${@}" || die
}

# @FUNCTION: distutils-r1_python_test
# @DESCRIPTION:
# The default python_test(). Currently a no-op.
distutils-r1_python_test() {
	debug-print-function ${FUNCNAME} "${@}"

	:
}

# @FUNCTION: distutils-r1_rename_scripts
# @DESCRIPTION:
# Renames installed Python scripts to be implementation-suffixed.
# ${PYTHON} has to be set to the expected Python executable (which
# hashbang will be grepped for), and ${EPYTHON} to the implementation
# name (for new name).
distutils-r1_rename_scripts() {
	debug-print-function ${FUNCNAME} "${@}"

	local f
	# XXX: change this if we ever allow directories in bin/sbin
	for f in "${D}"/{bin,sbin,usr/bin,usr/sbin}/*; do
		if [[ -x ${f} ]]; then
			debug-print "${FUNCNAME}: found executable at ${f#${D}/}"

			if [[ "$(head -n 1 "${f}")" == '#!'*${EPYTHON}* ]]
			then
				debug-print "${FUNCNAME}: matching shebang: $(head -n 1 "${f}")"

				local newf=${f}-${EPYTHON}
				debug-print "${FUNCNAME}: renamed to ${newf#${D}/}"
				mv "${f}" "${newf}" || die
			fi
		fi
	done
}

# @FUNCTION: distutils-r1_python_install
# @USAGE: [additional-args...]
# @DESCRIPTION:
# The default python_install(). Runs 'setup.py install' using
# the correct Python implementation, and appending the optimization
# flags. Then calls distutils-r1_rename_scripts. Any parameters passed
# to this function will be passed to setup.py.
distutils-r1_python_install() {
	debug-print-function ${FUNCNAME} "${@}"

	local flags

	case "${EPYTHON}" in
		jython*)
			flags=(--compile);;
		*)
			flags=(--compile -O2);;
	esac
	debug-print "${FUNCNAME}: [${EPYTHON}] flags: ${flags}"

	unset PYTHONDONTWRITEBYTECODE

	cd "${BUILD_DIR}" || die
	set -- "${PYTHON}" setup.py install "${flags[@]}" --root="${D}" "${@}"
	echo "${@}"
	"${@}" || die

	distutils-r1_rename_scripts
}

# @FUNCTION: distutils-r1_python_install_all
# @DESCRIPTION:
# The default python_install_all(). It symlinks wrappers
# for the implementation-suffixed executables and installs
# documentation.
distutils-r1_python_install_all() {
	debug-print-function ${FUNCNAME} "${@}"

	if declare -p DOCS &>/dev/null; then
		dodoc "${DOCS[@]}" || die "dodoc failed"
	else
		local f
		# same list as in PMS
		for f in README* ChangeLog AUTHORS NEWS TODO CHANGES \
				THANKS BUGS FAQ CREDITS CHANGELOG; do
			if [[ -s ${f} ]]; then
				dodoc "${f}" || die "(default) dodoc ${f} failed"
			fi
		done
	fi

	if declare -p HTML_DOCS &>/dev/null; then
		dohtml -r "${HTML_DOCS[@]}" || die "dohtml failed"
	fi

	# note: keep in sync with ...rename_scripts()
	# also, we assume that each script is installed for all impls
	local impl EPYTHON PYTHON
	for impl in "${PYTHON_COMPAT[@]}"; do
		if use "python_targets_${impl}"; then
			python_export "${impl}" EPYTHON
			break
		fi
	done

	for f in "${D}"/{bin,sbin,usr/bin,usr/sbin,games/bin}/*-"${EPYTHON}"; do
		if [[ -x ${f} ]]; then
			debug-print "${FUNCNAME}: found executable at ${f#${D}/}"

			local wrapf=${f%-${EPYTHON}}
			debug-print "${FUNCNAME}: will link wrapper to ${wrapf#${D}/}"
			local wrapfrom
			case "${f#${D}/}" in
				usr/bin*)
					wrapfrom=
					;;
				usr/sbin*)
					wrapfrom=../bin/
					;;
				*)
					wrapfrom=../usr/bin/
					;;
			esac
			debug-print "${FUNCNAME}: (from ${wrapfrom}python-exec)"

			ln -s ${wrapfrom}python-exec "${wrapf}" || die
		fi
	done
}

# @FUNCTION: distutils-r1_run_phase
# @USAGE: [<argv>...]
# @INTERNAL
# @DESCRIPTION:
# Run the given command in BUILD_DIR.
distutils-r1_run_phase() {
	debug-print-function ${FUNCNAME} "${@}"

	pushd "${BUILD_DIR}" &>/dev/null || die
	"${@}" || die "${1} failed."
	popd &>/dev/null || die
}

distutils-r1_src_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	# common preparations
	if declare -f python_prepare_all >/dev/null; then
		python_prepare_all
	else
		distutils-r1_python_prepare_all
	fi

	if declare -f python_prepare >/dev/null; then
		python_foreach_impl distutils-r1_run_phase python_prepare
	else
		python_foreach_impl distutils-r1_run_phase distutils-r1_python_prepare
	fi
}

distutils-r1_src_configure() {
	if declare -f python_configure >/dev/null; then
		python_foreach_impl distutils-r1_run_phase python_configure
	else
		python_foreach_impl distutils-r1_run_phase distutils-r1_python_configure
	fi

	if declare -f python_configure_all >/dev/null; then
		python_configure_all
	fi
}

distutils-r1_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	if declare -f python_compile >/dev/null; then
		python_foreach_impl distutils-r1_run_phase python_compile
	else
		python_foreach_impl distutils-r1_run_phase distutils-r1_python_compile
	fi

	if declare -f python_compile_all >/dev/null; then
		python_compile_all
	fi
}

distutils-r1_src_test() {
	debug-print-function ${FUNCNAME} "${@}"

	if declare -f python_test >/dev/null; then
		python_foreach_impl distutils-r1_run_phase python_test
	else
		python_foreach_impl distutils-r1_run_phase distutils-r1_python_test
	fi

	if declare -f python_test_all >/dev/null; then
		python_test_all
	fi
}

distutils-r1_src_install() {
	debug-print-function ${FUNCNAME} "${@}"

	if declare -f python_install >/dev/null; then
		python_foreach_impl distutils-r1_run_phase python_install
	else
		python_foreach_impl distutils-r1_run_phase distutils-r1_python_install
	fi

	if declare -f python_install_all >/dev/null; then
		python_install_all
	else
		distutils-r1_python_install_all
	fi
}
