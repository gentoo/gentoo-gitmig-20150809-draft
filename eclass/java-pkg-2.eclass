# Eclass for Java packages
#
# Copyright (c) 2004-2005, Thomas Matthijs <axxo@gentoo.org>
# Copyright (c) 2004-2005, Gentoo Foundation
#
# Licensed under the GNU General Public License, v2
#
# $Header: /var/cvsroot/gentoo-x86/eclass/java-pkg-2.eclass,v 1.11 2007/01/12 13:48:12 betelgeuse Exp $

inherit java-utils-2

# -----------------------------------------------------------------------------
# @eclass-begin
# @eclass-summary Eclass for Java Packages
#
# This eclass should be inherited for pure Java packages, or by packages which
# need to use Java.
# -----------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# @depend
#
# Java packages need java-config, and a fairly new release of Portage.
#
# JAVA_PKG_E_DEPEND is defined in java-utils.eclass.
# ------------------------------------------------------------------------------
DEPEND="${JAVA_PKG_E_DEPEND}"

# ------------------------------------------------------------------------------
# @rdepend
#
# Nothing special for RDEPEND... just the same as DEPEND.
# ------------------------------------------------------------------------------
RDEPEND="${DEPEND}"

EXPORT_FUNCTIONS pkg_setup src_compile

# ------------------------------------------------------------------------------
# @eclass-pkg_setup
#
# pkg_setup initializes the Java environment
# ------------------------------------------------------------------------------
java-pkg-2_pkg_setup() {
	java-pkg_init
	java-pkg_ensure-test
}

# ------------------------------------------------------------------------------
# @eclass-src_compile
#
# Default src_compile for java packages
# variables:
# EANT_BUILD_XML - controls the location of the build.xml (default: ./build.xml)
# EANT_FILTER_COMPILER - Calls java-pkg_filter-compiler with the value
# EANT_BUILD_TARGET - the ant target/targets to execute (default: jar)
# EANT_DOC_TARGET - the target to build extra docs under the doc use flag
#                   (default: the one provided by use_doc in
#                   java-utils-2.eclass)
# EANT_GENTOO_CLASSPATH - class java-pkg_getjars for the value and adds to the
#						  gentoo.classpath property
# EANT_EXTRA_ARGUMENTS - extra arguments to pass to eant
# ------------------------------------------------------------------------------
java-pkg-2_src_compile() {
	if [[ -e "${EANT_BUILD_XML:=build.xml}" ]]; then
		[[ "${EANT_FILTER_COMPILER}" ]] && \
			java-pkg_filter-compiler ${EANT_FILTER_COMPILER}

		local antflags="${EANT_BUILD_TARGET:=jar}"

		local gcp="${EANT_GENTOO_CLASSPATH}"

		if [[ "${gcp}" ]]; then
			local cp="$(java-pkg_getjars ${gcp})"
			# It seems ant does not like single quotes around ${cp}
			antflags="${antflags} -Dgentoo.classpath=\"${cp}\""
		fi

		hasq doc ${IUSE} && antflags="${antflags} $(use_doc ${EANT_DOC_TARGET})"
		eant ${antflags} -f "${EANT_BUILD_XML}" ${EANT_EXTRA_ARGUMENTS}
	else
		echo "${FUNCNAME}: No build.xml found so nothing to do."
	fi
}

# ------------------------------------------------------------------------------
# @note
#
# We need to initialize the environment in every function because Portage
# will source /etc/profile between phases and trample all over the env.
# This is accomplished by phase hooks, which is available with newer versions of
# portage.
# ------------------------------------------------------------------------------

pre_pkg_setup() {
	java-pkg-2_pkg_setup
}

pre_src_unpack() {
	java-pkg-2_pkg_setup
}

pre_src_compile() {
	if is-java-strict; then
		echo "Searching for bundled jars:"
		java-pkg_find-normal-jars || echo "None found."
	fi
	java-pkg-2_pkg_setup
}

pre_src_install() {
	java-pkg-2_pkg_setup
}

pre_src_test() {
	java-pkg-2_pkg_setup
}

pre_pkg_preinst() {
	java-pkg-2_pkg_setup
}

pre_pkg_postinst() {
	java-pkg-2_pkg_setup
}

# ------------------------------------------------------------------------------
# @eclass-end
# ------------------------------------------------------------------------------
