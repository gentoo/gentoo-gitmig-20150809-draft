# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-1.1.ebuild,v 1.3 2005/02/06 00:56:15 kloeri Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="sparc x86 alpha ~ia64 mips ~ppc ~amd64"
IUSE=""

RDEPEND="${RDEPEND} sys-apps/slocate"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides commands which hook vim into slocate:
\    :LocateEdit   filename
\    :LocateSplit  filename
\    :LocateSource filename
\    :LocateRead   filename
To configure:
\    :let g:locateopen_ignorecase = 1    \" enable ignore case mode
\    :let g:locateopen_smartcase = 0     \" disable smart case mode
\    :let g:locateopen_alwaysprompt = 1  \" show menu for one match"
