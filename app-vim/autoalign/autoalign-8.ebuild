# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/autoalign/autoalign-8.ebuild,v 1.3 2007/07/11 05:14:07 mr_bones_ Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: automatically align bib, c, c++, tex and vim code"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=884"
LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-vim/align-30
	>=app-vim/cecutil-4
	!>=app-editors/vim-core-7"

VIM_PLUGIN_HELPFILES="autoalign"
VIM_PLUGIN_MESSAGES="filetype"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Don't use the cecutil.vim included in the tarball, use the one
	# provided by app-vim/cecutil instead.
	rm plugin/cecutil.vim
}

pkg_postinst() {
	vim-plugin_pkg_postinst

	echo
	ewarn "This plugin may operate incorrectly when 've is set to a value"
	ewarn "other than 'all'."
	echo
}
