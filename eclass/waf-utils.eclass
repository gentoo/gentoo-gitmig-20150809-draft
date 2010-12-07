# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/waf-utils.eclass,v 1.1 2010/12/07 06:48:08 eva Exp $

# @ECLASS: waf-utils.eclass
# @MAINTAINER:
# gnome@gentoo.org
#
# @CODE
# Original Author: Gilles Dartiguelongue <eva@gentoo.org>
# @CODE
# @BLURB: common ebuild functions for waf-based packages
# @DESCRIPTION:
# The waf-utils eclass contains functions that make creating ebuild for
# waf-based packages much easier.
# Its main features are support of common portage default settings.

inherit base eutils multilib python

case ${EAPI:-0} in
	3|2) EXPORT_FUNCTIONS pkg_setup src_configure src_compile src_install ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @ECLASS-VARIABLE: DOCS
# @DESCRIPTION:
# Documents passed to dodoc command.

# @FUNCTION: waf-utils_src_configure
# @DESCRIPTION:
# General function for configuring with waf.
waf-utils_pkg_setup() {
	python_set_active_version 2
}

# @FUNCTION: waf-utils_src_configure
# @DESCRIPTION:
# General function for configuring with waf.
waf-utils_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${S}"/waf \
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
	"${S}"/waf build ${jobs} || die "build failed"
}

# @FUNCTION: waf-utils_src_install
# @DESCRIPTION:
# Function for installing the package.
waf-utils_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	has ${EAPI:-0} 2 && ! use prefix && ED="${D}"

	"${S}"/waf --destdir="${ED}" install  || die "Make install failed"

	# Manual document installation
	[[ -n "${DOCS}" ]] && { dodoc ${DOCS} || die "dodoc failed" ; }
}

