# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfconf.eclass,v 1.35 2011/06/06 14:38:46 angelos Exp $

# @ECLASS: xfconf.eclass
# @MAINTAINER:
# XFCE maintainers <xfce@gentoo.org>
# @BLURB: Default XFCE ebuild layout
# @DESCRIPTION:
# Default XFCE ebuild layout

# @ECLASS-VARIABLE: EAUTORECONF
# @DESCRIPTION:
# Run eautoreconf instead of elibtoolize if the variable is set

# @ECLASS-VARIABLE: EINTLTOOLIZE
# @DESCRIPTION:
# Run intltoolize --force --copy --automake if the variable is set

# @ECLASS-VARIABLE: DOCS
# @DESCRIPTION:
# This should be an array defining documentation to install

# @ECLASS-VARIABLE: PATCHES
# @DESCRIPTION:
# This should be an array defining patches to apply

# @ECLASS-VARIABLE: XFCONF
# @DESCRIPTION:
# This should be an array defining arguments for econf

inherit autotools base eutils fdo-mime gnome2-utils libtool

if [[ -n $EINTLTOOLIZE ]]; then
	_xfce4_intltool="dev-util/intltool"
fi

if [[ -n $EAUTORECONF ]]; then
	_xfce4_m4=">=dev-util/xfce4-dev-tools-4.8.0"
fi

RDEPEND=""
DEPEND="${_xfce4_intltool}
	${_xfce4_m4}"

unset _xfce4_intltool
unset _xfce4_m4

case ${EAPI:-0} in
	4|3) ;;
	*) die "Unknown EAPI." ;;
esac

EXPORT_FUNCTIONS src_prepare src_configure src_install pkg_preinst pkg_postinst pkg_postrm

# @FUNCTION: xfconf_use_debug
# @DESCRIPTION:
# If IUSE has debug, return --enable-debug=minimum.
# If USE debug is enabled, return --enable-debug which is the same as --enable-debug=yes.
# If USE debug is enabled and the XFCONF_FULL_DEBUG variable is set, return --enable-debug=full.
xfconf_use_debug() {
	if has debug ${IUSE}; then
		if use debug; then
			if [[ -n $XFCONF_FULL_DEBUG ]]; then
				echo "--enable-debug=full"
			else
				echo "--enable-debug"
			fi
		else
			echo "--enable-debug=minimum"
		fi
	else
		ewarn "${FUNCNAME} called without debug in IUSE"
	fi
}

# @FUNCTION: xfconf_src_prepare
# @DESCRIPTION:
# Run base_src_prepare and eautoreconf or elibtoolize
xfconf_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"
	base_src_prepare

	if [[ -n $EINTLTOOLIZE ]]; then
		local _intltoolize="intltoolize --force --copy --automake"
		ebegin "Running ${_intltoolize}"
		${_intltoolize} || die
		eend $?
	fi

	if [[ -n $EAUTORECONF ]]; then
		AT_M4DIR=${EPREFIX}/usr/share/xfce4/dev-tools/m4macros eautoreconf
	else
		elibtoolize
	fi
}

# @FUNCTION: xfconf_src_configure
# @DESCRIPTION:
# Run econf with opts from the XFCONF array
xfconf_src_configure() {
	debug-print-function ${FUNCNAME} "$@"
	econf "${XFCONF[@]}"
}

# @FUNCTION: xfconf_src_install
# @DESCRIPTION:
# Run emake install and install documentation in the DOCS array
xfconf_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	emake DESTDIR="${D}" "$@" install || die

	[[ -n ${DOCS[@]} ]] && dodoc "${DOCS[@]}"

	find "${ED}" -name '*.la' -exec rm -f {} +

	validate_desktop_entries
}

# @FUNCTION: xfconf_pkg_preinst
# @DESCRIPTION:
# Run gnome2_icon_savelist
xfconf_pkg_preinst() {
	debug-print-function ${FUNCNAME} "$@"
	gnome2_icon_savelist
}

# @FUNCTION: xfconf_pkg_postinst
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfconf_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

# @FUNCTION: xfconf_pkg_postrm
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfconf_pkg_postrm() {
	debug-print-function ${FUNCNAME} "$@"
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
