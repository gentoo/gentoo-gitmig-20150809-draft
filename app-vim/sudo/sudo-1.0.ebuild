# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/sudo/sudo-1.0.ebuild,v 1.7 2005/02/22 23:09:45 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: edit restricted files from a normal vim session"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=729"
LICENSE="as-is"
KEYWORDS="x86 sparc mips ~ppc amd64 alpha ia64"
IUSE=""

RDEPEND="app-admin/sudo"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides :SudoRead and :SudoWrite commands to allow reading from
and writing to restricted files from a normal vim session."

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/^echo/d' plugin/sudo.vim
}

