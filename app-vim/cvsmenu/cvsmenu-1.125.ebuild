# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvsmenu/cvsmenu-1.125.ebuild,v 1.1 2006/09/08 20:56:29 pioto Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS(NT) integration script"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1245"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

# Note, this comes from CVS on sf.net
# http://ezytools.cvs.sourceforge.net/*checkout*/ezytools/VimTools/cvsmenu.txt
VIM_PLUGIN_HELPFILES="cvsmenu.txt"

RDEPEND="dev-util/cvs"
