# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/toggle/toggle-1.3.ebuild,v 1.6 2004/09/06 22:06:03 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: quickly toggle boolean-type keywords"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=895"
LICENSE="GPL-2"
KEYWORDS="~x86 sparc mips ~ppc"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin will toggle true/false, on/off, yes/no and so on when <C-T>
is pressed."
