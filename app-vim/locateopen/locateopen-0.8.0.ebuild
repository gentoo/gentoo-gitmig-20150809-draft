# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-0.8.0.ebuild,v 1.3 2004/02/06 09:31:32 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://vim.sourceforge.net/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="sparc x86 alpha ia64 ~mips"

RDEPEND="${RDEPEND} sys-apps/slocate"

