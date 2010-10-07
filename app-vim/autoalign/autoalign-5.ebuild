# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/autoalign/autoalign-5.ebuild,v 1.10 2010/10/07 02:55:31 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: automatically align bib, c, c++, tex and vim code"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=884"
LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND=">=app-vim/align-30
	>=app-vim/cecutil-4
	!>=app-editors/vim-core-7"

VIM_PLUGIN_HELPFILES="autoalign"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Don't use the cecutil.vim included in the tarball, use the one
	# provided by app-vim/cecutil instead.
	rm plugin/cecutil.vim
}

pkg_postinst() {
	vim-plugin_pkg_postinst

	ewarn
	ewarn "This plugin only works properly when vim is in virtualedit"
	ewarn "mode. To enable this, use:"
	ewarn "    :set virtualedit=all"
	ewarn
}
