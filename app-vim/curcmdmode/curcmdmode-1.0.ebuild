# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/curcmdmode/curcmdmode-1.0.ebuild,v 1.7 2005/02/22 23:22:12 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library for extending vim's mode() function"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=745"
LICENSE="GPL-2"
KEYWORDS="x86 sparc mips ~ppc alpha ia64"
IUSE=""

RDEPEND=">=app-vim/genutils-1.7"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
