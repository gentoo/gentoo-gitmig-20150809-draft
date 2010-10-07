# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/breakpts/breakpts-3.1.ebuild,v 1.10 2010/10/07 02:57:25 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: sets vim breakpoints visually"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=618"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="
	|| ( >=app-editors/vim-6.3 >=app-editors/gvim-6.3 )
	>=app-vim/multvals-3.6.1
	>=app-vim/genutils-1.13
	>=app-vim/foldutil-1.6"

VIM_PLUGIN_HELPTEXT=\
"This plugin allows breakpoints to be set and cleared visually. To start,
use :BreakPts, move to the required function and press <CR>. Breakpoints
can then be added using :BPToggle or <F9>."
