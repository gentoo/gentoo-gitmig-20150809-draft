# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/align/align-28.ebuild,v 1.2 2004/09/03 00:03:46 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: commands and maps to help produce aligned text"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=294"
LICENSE="vim"
KEYWORDS="~x86 ~alpha ~sparc ~ia64 ~ppc ~mips"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"To use this plugin, press <Tab> whilst in insert mode. Words will be
autocompleted as per <ctrl-n>. Completion mode can be changed using
<ctrl-x> (see :help insert_expand). To insert an actual tab character,
either use <ctrl-v><Tab> or enter a space followed by a tab."
