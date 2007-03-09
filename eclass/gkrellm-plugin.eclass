# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gkrellm-plugin.eclass,v 1.1 2007/03/09 15:35:02 lack Exp $

#
# Original Author: Jim Ramsay <lack@gentoo.org>
#
# Purpose:
#   Provides common methods used by (almost) all gkrellm plugins:
#    - Sets up default dependencies
#    - Adds pkg_setup check to ensure gkrellm was built with USE="X" (bug
#    167227)
#    - Provides 'gkrellm-plugin_dir' function in lieu of hard-coding the plugins
#    directory (which *may* change in the future)
#    - Provides the most common src_install method to avoid code duplication.
#
# Utility Routines:
#   gkrellm-plugin_dir - Returns the gkrellm-2 plugin directory
#
# Environment:
#   For pkg_setup:
#     PLUGIN_NO_XCHECK - If set, the default check ensuring that gkrellm2 is
#       built with USE="X" is skipped, allowing plugins to build with the
#       gkrellmd-only case.  Defaults to unset.
#   For src_install:
#     PLUGIN_SO - The name of the plugin's .so file which will be installed in
#       the plugin dir.  Defaults to "${PN}.so".
#     PLUGIN_DOCS - An optional list of docs to be installed.  Defaults to
#       unset.
#
# Changelog:
#   09 March 2007: Jim Ramsay <lack@gentoo.org>
#     - Initial commit
#

inherit multilib eutils

RDEPEND="=app-admin/gkrellm-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

gkrellm-plugin_dir() {
	echo /usr/$(get_libdir)/gkrellm2/plugins
}

gkrellm-plugin_pkg_setup() {
	if [[ -z "${PLUGIN_NO_XCHECK}" ]] && 
		! built_with_use app-admin/gkrellm X; then
		eerror "This plugin requires the X frontend of gkrellm."
		eerror "Please re-emerge app-admin/gkrellm with USE=\"X\""
		die "Please re-emerge app-admin/gkrellm with USE=\"X\""
	fi
}

gkrellm-plugin_src_install() {
	insinto $(gkrellm-plugin_dir)
	doins ${PLUGIN_SO:-${PN}.so} || die "Plugin shared library was not installed"

	DDOCS="README* Change* AUTHORS FAQ TODO INSTALL"

	for doc in ${DDOCS}; do
		[ -s "$doc" ] && dodoc $doc
	done

	[ -n "${PLUGIN_DOCS}" ] && dodoc ${PLUGIN_DOCS}
}

EXPORT_FUNCTIONS pkg_setup src_install
