# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/taglist/taglist-3.4.ebuild,v 1.4 2004/09/09 20:46:29 kugelfang Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: ctags-based source code browser"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=273"
LICENSE="vim"
KEYWORDS="x86 ~alpha sparc ~ia64 ~ppc mips amd64"
IUSE=""

RDEPEND="dev-util/ctags"

VIM_PLUGIN_HELPFILES="taglist-intro"
