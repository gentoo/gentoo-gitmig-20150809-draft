# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/breakpts/breakpts-3.1.ebuild,v 1.2 2004/07/17 19:23:39 dholm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: sets vim breakpoints visually"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=618"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips ~ppc"
IUSE=""

RDEPEND="
	|| ( >=app-editors/vim-6.3 >=app-editors/gvim-6.3 )
	>=app-vim/multvals-3.6.1
	>=app-vim/genutils-1.13
	>=app-vim/foldutil-1.6"
