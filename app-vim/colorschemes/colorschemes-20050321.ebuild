# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorschemes/colorschemes-20050321.ebuild,v 1.4 2005/04/01 03:49:15 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: a collection of color schemes from vim.org"
HOMEPAGE="http://www.vim.org/tips/tip.php?tip_id=693"

LICENSE="vim GPL-2 public-domain as-is"
KEYWORDS="alpha ~amd64 ia64 mips ~ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a collection of color schemes for vim. To switch
color schemes, use :colorscheme schemename (tab completion is available
for scheme names). To automatically set a scheme at startup, please see
:help vimrc ."

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -type f -exec sed -i -e 's/\r//g' '{}' \;
}

