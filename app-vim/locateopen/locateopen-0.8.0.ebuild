# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-0.8.0.ebuild,v 1.2 2004/01/23 15:44:23 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://vim.sourceforge.net/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="~sparc ~x86 alpha ia64"

RDEPEND="${RDEPEND} sys-apps/slocate"

