# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-0.6.2.ebuild,v 1.1 2003/12/19 01:35:22 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://vim.sourceforge.net/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="~sparc ~x86"

RDEPEND="${RDEPEND} sys-apps/slocate"

