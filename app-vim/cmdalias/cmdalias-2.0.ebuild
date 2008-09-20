# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cmdalias/cmdalias-2.0.ebuild,v 1.1 2008/09/20 13:54:39 hawking Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library for alias creation"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=746"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""
RDEPEND=">=app-vim/curcmdmode-1.0"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
