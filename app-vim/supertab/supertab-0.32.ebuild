# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/supertab/supertab-0.32.ebuild,v 1.10 2004/09/05 01:35:12 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: enhanced Tab key functionality"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=182"

LICENSE="vim"
KEYWORDS="alpha sparc x86 ~ppc amd64 ia64 mips"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"To use this plugin, press <Tab> whilst in insert mode. Words will be
autocompleted as per <ctrl-n>. Completion mode can be changed using
<ctrl-x> (see :help insert_expand). To insert an actual tab character,
either use <ctrl-v><Tab> or enter a space followed by a tab."
