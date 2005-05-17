# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/greputils/greputils-2.3.ebuild,v 1.5 2005/05/17 17:13:57 ka0ttic Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: interface with grep, find and id-utils"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1062"
LICENSE="GPL-2"
KEYWORDS="x86 sparc mips ~ppc"
IUSE=""

VIM_PLUGIN_HELPURI="${HOMEPAGE}"

RDEPEND="
	${RDEPEND}
	>=app-vim/genutils-1.13
	>=app-vim/multvals-3.6.1"
