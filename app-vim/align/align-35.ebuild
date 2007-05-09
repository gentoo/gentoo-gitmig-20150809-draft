# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/align/align-35.ebuild,v 1.1 2007/05/09 19:25:05 pioto Exp $

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: commands and maps to help produce aligned text"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=294"

LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
RDEPEND="app-vim/cecutil"

VIM_PLUGIN_HELPFILES="align align-maps"

src_unpack() {
	unpack ${A}
	cd ${S}
	# nuke cecutil, we use the common shared version
	rm -f plugin/cecutil.vim
}
