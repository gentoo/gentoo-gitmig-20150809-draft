# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorschemes/colorschemes-20040821.ebuild,v 1.4 2004/09/06 22:46:36 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: a collection of color schemes from vim.sf.net"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=625"
LICENSE="vim GPL-2 public-domain"
KEYWORDS="~alpha sparc x86 ~ppc ~ia64 mips ~amd64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a collection of color schemes for vim. To switch
color schemes, use :colorscheme schemename (tab completion is available
for scheme names). To automatically set a scheme at startup, please see
:help vimrc . In the GUI, a Themes menu is provided."
