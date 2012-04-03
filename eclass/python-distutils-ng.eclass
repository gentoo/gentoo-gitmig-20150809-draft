# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/python-distutils-ng.eclass,v 1.11 2012/04/03 19:21:45 nelchael Exp $

# @ECLASS: python-distutils-ng
# @MAINTAINER:
# Python herd <python@gentoo.org>
# @AUTHOR:
# Author: Krzysztof Pawlik <nelchael@gentoo.org>
# @BLURB: An eclass for installing Python packages using distutils with proper
# support for multiple Python slots.
# @DESCRIPTION:
# The Python eclass is designed to allow an easier installation of Python
# packages and their incorporation into the Gentoo Linux system.
#
# This eclass provides functions for following phases:
#  - src_prepare - you can define python_prepare_all function that will be run
#    before creating implementation-specific directory and python_prepare
#    function that will be run for each implementation
#  - src_configure - you can define python_configure function that will be run
#    for each implementation
#  - src_compile - you can define python_compile function that will be run for
#    each implementation, default function will run `setup.py build'
#  - src_test - you can define python_test function that will be run for each
#    implementation
#  - src_install - you can define python_install function that will be run for
#    each implementation and python_install_all that will be run in original
#    directory (so it will not contain any implementation-specific files)

# @ECLASS-VARIABLE: PYTHON_COMPAT
# @DESCRIPTION:
# This variable contains a space separated list of implementations (see above) a
# package is compatible to. It must be set before the `inherit' call. The
# default is to enable all implementations.

if [[ -z "${PYTHON_COMPAT}" ]]; then
	# Default: pure python, support all implementations
	PYTHON_COMPAT="  python2_5 python2_6 python2_7"
	PYTHON_COMPAT+=" python3_1 python3_2"
	PYTHON_COMPAT+=" jython2_5"
	PYTHON_COMPAT+=" pypy1_7 pypy1_8"
fi

# @ECLASS-VARIABLE: PYTHON_OPTIONAL
# @DESCRIPTION:
# Set the value to "yes" to make the dependency on a Python interpreter
# optional.

# @ECLASS-VARIABLE: PYTHON_DISABLE_COMPILATION
# @DESCRIPTION:
# Set the value to "yes" to skip compilation and/or optimization of Python
# modules.

EXPORT_FUNCTIONS pkg_pretend src_prepare src_configure src_compile src_test src_install

case "${EAPI}" in
	0|1|2|3)
		die "Unsupported EAPI=${EAPI} (too old) for python-distutils-ng.eclass" ;;
	4)
		# EAPI=4 needed for REQUIRED_USE
		S="${S:-${WORKDIR}/${P}}"
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for python-distutils-ng.eclass" ;;
esac

# @FUNCTION: _python-distutils-ng_get_binary_for_implementation
# @USAGE: implementation
# @RETURN: Full path to Python binary for given implementation.
# @DESCRIPTION:
# This function returns full path for Python binary for given implementation.
#
# Binary returned by this function should be used instead of simply calling
# `python'.
_python-distutils-ng_get_binary_for_implementation() {
	local impl="${1/_/.}"
	case "${impl}" in
		python?.?|jython?.?)
			echo "/usr/bin/${impl}" ;;
		pypy?.?)
			echo "/usr/bin/pypy-c${impl: -3}" ;;
		*)
			die "Unsupported implementation: ${1}" ;;
	esac
}

required_use_str=""
for impl in ${PYTHON_COMPAT}; do
	required_use_str+=" python_targets_${impl}"
done
required_use_str=" || ( ${required_use_str} )"
if [[ "${PYTHON_OPTIONAL}" = "yes" ]]; then
	IUSE+=" python"
	REQUIRED_USE+=" python? ( ${required_use_str} )"
else
	REQUIRED_USE+=" ${required_use_str}"
fi
unset required_use_str

for impl in ${PYTHON_COMPAT}; do
	IUSE+=" python_targets_${impl}"
	dep_str="${impl/_/.}"
	case "${dep_str}" in
		python?.?)
			dep_str="dev-lang/python:${dep_str: -3}" ;;
		jython?.?)
			dep_str="dev-java/jython:${dep_str: -3}" ;;
		pypy?.?)
			dep_str="dev-python/pypy:${dep_str: -3}" ;;
		*)
			die "Unsupported implementation: ${impl}" ;;
	esac
	dep_str="python_targets_${impl}? ( ${dep_str} )"

	if [[ "${PYTHON_OPTIONAL}" = "yes" ]]; then
		RDEPEND="${RDEPEND} python? ( ${dep_str} )"
		DEPEND="${DEPEND} python? ( ${dep_str} )"
	else
		RDEPEND="${RDEPEND} ${dep_str}"
		DEPEND="${DEPEND} ${dep_str}"
	fi
	unset dep_str
done

_PACKAGE_SPECIFIC_S="${S#${WORKDIR}/}"

# @FUNCTION: _python-distutils-ng_run_for_impl
# @USAGE: implementation command_to_run
# @DESCRIPTION:
# Run command_to_run using specified Python implementation.
#
# This will run the command_to_run in implementation-specific working directory.
_python-distutils-ng_run_for_impl() {
	local impl="${1}"
	local command="${2}"

	S="${WORKDIR}/impl_${impl}/${_PACKAGE_SPECIFIC_S}"
	PYTHON="$(_python-distutils-ng_get_binary_for_implementation "${impl}")"
	EPYTHON="${impl/_/.}"

	einfo "Running ${command} in ${S} for ${impl}"

	pushd "${S}" &> /dev/null
	"${command}" "${impl}" "${PYTHON}"
	popd &> /dev/null
}

# @FUNCTION: _python-distutils-ng_run_for_each_impl
# @USAGE: command_to_run
# @DESCRIPTION:
# Run command_to_run for all enabled Python implementations.
#
# See also _python-distutils-ng_run_for_impl
_python-distutils-ng_run_for_each_impl() {
	local command="${1}"

	for impl in ${PYTHON_COMPAT}; do
		use "python_targets_${impl}" ${PYTHON_COMPAT} || continue
		_python-distutils-ng_run_for_impl "${impl}" "${command}"
	done
}

# @FUNCTION: _python-distutils-ng_default_distutils_compile
# @DESCRIPTION:
# Default src_compile for distutils-based packages.
_python-distutils-ng_default_distutils_compile() {
	"${PYTHON}" setup.py build || die
}

# @FUNCTION: _python-distutils-ng_default_distutils_install
# @DESCRIPTION:
# Default src_install for distutils-based packages.
_python-distutils-ng_default_distutils_install() {
	"${PYTHON}" setup.py install --no-compile --root="${D}/" || die
}

# @FUNCTION: _python-distutils-ng_has_compileall
# @USAGE: implementation
# @RETURN: 0 if given implementation has compileall module
# @DESCRIPTION:
# This function is used to decide whenever to compile Python modules for given
# implementation.
_python-distutils-ng_has_compileall() {
	case "${1}" in
		python?_?|jython?_?)
			return 0 ;;
		*)
			return 1 ;;
	esac
}

# @FUNCTION: _python-distutils-ng_has_compileall_opt
# @USAGE: implementation
# @RETURN: 0 if given implementation has compileall module and supports # optimizations
# @DESCRIPTION:
# This function is used to decide whenever to compile and optimize Python
# modules for given implementation.
_python-distutils-ng_has_compileall_opt() {
	case "${1}" in
		python?_?)
			return 0 ;;
		*)
			return 1 ;;
	esac
}

# @FUNCTION: python-distutils-ng_redoscript
# @USAGE: script_file_path [destination_directory]
# @DESCRIPTION:
# Reinstall script installed already by setup.py. This works by first moving the
# script to ${T} directory and later running python-distutils-ng_doscript on it.
# script_file_path has to be a full path relative to ${D}.
python-distutils-ng_redoscript() {
	local sbn="$(basename "${1}")"
	mkdir -p "${T}/_${sbn}/" || die "failed to create directory"
	mv "${D}/${1}" "${T}/_${sbn}/${sbn}" || die "failed to move file"
	python-distutils-ng_doscript "${T}/_${sbn}/${sbn}" "${2}"
}

# @FUNCTION: python-distutils-ng_doscript
# @USAGE: script_file_name [destination_directory]
# @DESCRIPTION:
# Install given script file in destination directory (for default value check
# python-distutils-ng_newscript) for all enabled implementations using original
# script name as a base name.
#
# See also python-distutils-ng_newscript for more details.
python-distutils-ng_doscript() {
	python-distutils-ng_newscript "${1}" "$(basename "${1}")" "${2}"
}

# @FUNCTION: python-distutils-ng_newscript
# @USAGE: script_file_name new_file_name [destination_directory]
# @DESCRIPTION:
# Install given script file in destination directory for all enabled
# implementations using new_file_name as a base name.
#
# Destination directory defaults to /usr/bin.
#
# If only one Python implementation is enabled the script will be installed
# as-is. Otherwise each script copy will have the name mangled to
# "new_file_name-IMPLEMENTATION". For every installed script new hash-bang line
# will be inserted to reference specific Python interpreter.
#
# In case of multiple implementations there will be also a symlink with name
# equal to new_file_name that will be a symlink to default implementation, which
# defaults to value of PYTHON_DEFAULT_IMPLEMENTATION, if not specified the
# function will pick default implementation: it will the be first enabled one
# from the following list:
#   python2_7, python2_6, python2_5, python3_2, python3_1, pypy1_8, pypy1_7, jython2_5
python-distutils-ng_newscript() {
	[[ -n "${1}" ]] || die "Missing source file name"
	[[ -n "${2}" ]] || die "Missing destination file name"
	local source_file="${1}"
	local destination_file="${2}"
	local default_impl="${PYTHON_DEFAULT_IMPLEMENTATION}"
	local enabled_impls=0
	local destination_directory="/usr/bin"
	[[ -n "${3}" ]] && destination_directory="${3}"

	for impl in ${PYTHON_COMPAT}; do
		use "python_targets_${impl}" || continue
		enabled_impls=$((enabled_impls + 1))
	done

	if [[ -z "${default_impl}" ]]; then
		for impl in python{2_7,2_6,2_5,3_2,3_1} pypy{1_8,1_7} jython2_5; do
			use "python_targets_${impl}" || continue
			default_impl="${impl}"
			break
		done
	else
		use "python_targets_${default_impl}" || \
			die "default implementation ${default_impl} not enabled"
	fi

	[[ -n "${default_impl}" ]] || die "Could not select default implementation"

	dodir "${destination_directory}"
	insinto "${destination_directory}"
	if [[ "${enabled_impls}" = "1" ]]; then
		einfo "Installing ${source_file} for single implementation (${default_impl}) in ${destination_directory}"
		newins "${source_file}" "${destination_file}"
		fperms 755 "${destination_directory}/${destination_file}"
		sed -i \
			-e "1i#!$(_python-distutils-ng_get_binary_for_implementation "${impl}")" \
			"${D}${destination_directory}/${destination_file}" || die
	else
		einfo "Installing ${source_file} for multiple implementations (default: ${default_impl}) in ${destination_directory}"
		for impl in ${PYTHON_COMPAT}; do
			use "python_targets_${impl}" ${PYTHON_COMPAT} || continue

			newins "${source_file}" "${destination_file}-${impl}"
			fperms 755 "${destination_directory}/${destination_file}-${impl}"
			sed -i \
				-e "1i#!$(_python-distutils-ng_get_binary_for_implementation "${impl}")" \
				"${D}${destination_directory}/${destination_file}-${impl}" || die
		done

		dosym "${destination_file}-${default_impl}" "${destination_directory}/${destination_file}"
	fi
}

# Phase function: pkg_pretend
python-distutils-ng_pkg_pretend() {
	if has "collision-protect" ${FEATURES}; then
		eerror "Due to previous eclass compiling Python files outside of src_install"
		eerror "(and not recording resulting .pyc and .pyo files as owned by any package)"
		eerror "merging this package with \"collision-protect\" in FEATURES will result"
		eerror "in an error, please switch to using \"protect-owned\" instead."
		die "\"collision-protect\" in FEATURES detected"
	fi
}

# Phase function: src_prepare
python-distutils-ng_src_prepare() {
	[[ "${PYTHON_OPTIONAL}" = "yes" ]] && { use python || return; }

	# Try to run binary for each implementation:
	for impl in ${PYTHON_COMPAT}; do
		use "python_targets_${impl}" ${PYTHON_COMPAT} || continue
		$(_python-distutils-ng_get_binary_for_implementation "${impl}") \
			-c "import sys" || die
	done

	# Run prepare shared by all implementations:
	if type python_prepare_all &> /dev/null; then
		einfo "Running python_prepare_all in ${S} for all"
		python_prepare_all
	fi

	# Create a copy of S for each implementation:
	for impl in ${PYTHON_COMPAT}; do
		use "python_targets_${impl}" ${PYTHON_COMPAT} || continue

		einfo "Creating copy for ${impl} in ${WORKDIR}/impl_${impl}"
		mkdir -p "${WORKDIR}/impl_${impl}" || die
		cp -pr "${S}" "${WORKDIR}/impl_${impl}/${_PACKAGE_SPECIFIC_S}" || die
	done

	# Run python_prepare for each implementation:
	if type python_prepare &> /dev/null; then
		_python-distutils-ng_run_for_each_impl python_prepare
	fi
}

# Phase function: src_configure
python-distutils-ng_src_configure() {
	[[ "${PYTHON_OPTIONAL}" = "yes" ]] && { use python || return; }

	if type python_configure &> /dev/null; then
		_python-distutils-ng_run_for_each_impl python_configure
	fi
}

# Phase function: src_compile
python-distutils-ng_src_compile() {
	[[ "${PYTHON_OPTIONAL}" = "yes" ]] && { use python || return; }

	if type python_compile &> /dev/null; then
		_python-distutils-ng_run_for_each_impl python_compile
	else
		_python-distutils-ng_run_for_each_impl \
			_python-distutils-ng_default_distutils_compile
	fi
}

# Phase function: src_test
python-distutils-ng_src_test() {
	[[ "${PYTHON_OPTIONAL}" = "yes" ]] && { use python || return; }

	if type python_test &> /dev/null; then
		_python-distutils-ng_run_for_each_impl python_test
	fi
}

# Phase function: src_install
python-distutils-ng_src_install() {
	[[ "${PYTHON_OPTIONAL}" = "yes" ]] && { use python || return; }

	if type python_install &> /dev/null; then
		_python-distutils-ng_run_for_each_impl python_install
	else
		_python-distutils-ng_run_for_each_impl \
			_python-distutils-ng_default_distutils_install
	fi

	S="${WORKDIR}/${_PACKAGE_SPECIFIC_S}"
	if type python_install_all &> /dev/null; then
		einfo "Running python_install_all in ${S} for all"
		python_install_all
	fi

	for impl in ${PYTHON_COMPAT}; do
		[[ "${PYTHON_DISABLE_COMPILATION}" = "yes" ]] && continue
		use "python_targets_${impl}" ${PYTHON_COMPAT} || continue

		PYTHON="$(_python-distutils-ng_get_binary_for_implementation "${impl}")"
		for accessible_path in $(${PYTHON} -c 'import sys; print " ".join(sys.path)'); do
			[[ -d "${D}/${accessible_path}" ]] || continue

			_python-distutils-ng_has_compileall "${impl}" || continue
			ebegin "Compiling ${accessible_path} for ${impl}"
			${PYTHON} \
				-m compileall -q -f "${D}/${accessible_path}" || die
			eend $?

			_python-distutils-ng_has_compileall_opt "${impl}" || continue
			ebegin "Optimizing ${accessible_path} for ${impl}"
			PYTHONOPTIMIZE=1 ${PYTHON} \
				-m compileall -q -f "${D}/${accessible_path}" || die
			eend $?
		done;
	done
}
