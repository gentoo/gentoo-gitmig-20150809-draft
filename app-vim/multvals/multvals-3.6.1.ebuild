# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/multvals/multvals-3.6.1.ebuild,v 1.5 2004/09/05 01:06:32 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library for helping with arrays"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=171"
LICENSE="GPL-2"
KEYWORDS="x86 sparc mips ~ppc"
IUSE=""

RDEPEND="|| ( >=app-editors/vim-6.3 >=app-editors/gvim-6.3 )"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
