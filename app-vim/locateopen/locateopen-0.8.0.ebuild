# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-0.8.0.ebuild,v 1.8 2004/08/25 16:17:34 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="sparc x86 alpha ia64 mips ~ppc"
IUSE=""

RDEPEND="${RDEPEND} sys-apps/slocate"
