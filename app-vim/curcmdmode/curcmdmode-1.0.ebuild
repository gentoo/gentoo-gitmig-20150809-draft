# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/curcmdmode/curcmdmode-1.0.ebuild,v 1.9 2006/11/20 07:48:33 wormo Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library for extending vim's mode() function"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=745"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 mips ppc sparc x86"
IUSE=""

RDEPEND=">=app-vim/genutils-1.7"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
