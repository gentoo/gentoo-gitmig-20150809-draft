# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/sudo/sudo-2.0.ebuild,v 1.1 2007/01/11 04:47:47 pioto Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: edit restricted files from a normal vim session"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=729"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-admin/sudo"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides :SudoRead and :SudoWrite commands to allow reading from
and writing to restricted files from a normal vim session."
