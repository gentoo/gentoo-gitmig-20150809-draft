# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/genutils/genutils-2.3.ebuild,v 1.1 2006/09/09 16:04:23 pioto Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library with various useful functions"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=197"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( >=app-editors/vim-7
	>=app-editors/gvim-7 )"
RDEPEND="${DEPEND}"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
