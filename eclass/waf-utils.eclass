# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/waf-utils.eclass,v 1.2 2011/01/13 18:43:58 scarabeus Exp $

# @ECLASS: waf-utils.eclass
# @MAINTAINER:
# gnome@gentoo.org
#
# @CODE
# Original Author: Gilles Dartiguelongue <eva@gentoo.org>
# Various improvements based on cmake-utils.eclass: Tomáš Chvátal <scarabeus@gentoo.org>
# @CODE
# @BLURB: common ebuild functions for waf-based packages
# @DESCRIPTION:
# The waf-utils eclass contains functions that make creating ebuild for
# waf-based packages much easier.
# Its main features are support of common portage default settings.

inherit base eutils multilib python

case ${EAPI:-0} in
	4|3|2) EXPORT_FUNCTIONS pkg_setup src_configure src_compile src_install ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @FUNCTION: waf-utils_src_configure
# @DESCRIPTION:
# General function for configuring with waf.
waf-utils_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"

	python_set_active_version 2

	# @ECLASS-VARIABLE: WAF_BINARY
	# @DESCRIPTION:
	# Eclass can use different waf executable. Usually it is located in "${S}/waf".
	: ${WAF_BINARY:="${S}/waf"}
}

# @FUNCTION: waf-utils_src_configure
# @DESCRIPTION:
# General function for configuring with waf.
waf-utils_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" \"${WAF_BINARY}\" --prefix=/usr --libdir=/usr/$(get_libdir) $@ configure"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		$@ \
		configure || die "configure failed"
}

# @FUNCTION: waf-utils_src_compile
# @DESCRIPTION:
# General function for compiling with waf.
waf-utils_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	local jobs=$(echo -j1 ${MAKEOPTS} | sed -r "s/.*(-j\s*|--jobs=)([0-9]+).*/--jobs=\2/" )
	echo "\"${WAF_BINARY}\" build ${jobs}"
	"${WAF_BINARY}" ${jobs} || die "build failed"
}

# @FUNCTION: waf-utils_src_install
# @DESCRIPTION:
# Function for installing the package.
waf-utils_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	has ${EAPI:-0} 2 && ! use prefix && ED="${D}"
	echo "\"${WAF_BINARY}\" --destdir=\"${ED}\" install"
	"${WAF_BINARY}" --destdir="${ED}" install  || die "Make install failed"

	# Manual document installation
	base_src_install_docs
}
