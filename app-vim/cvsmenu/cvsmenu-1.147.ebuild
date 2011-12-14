# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvsmenu/cvsmenu-1.147.ebuild,v 1.5 2011/12/14 09:24:38 phajdan.jr Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS(NT) integration script"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1245"
LICENSE="LGPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

# Note, this comes from CVS on sf.net
# http://ezytools.cvs.sourceforge.net/*checkout*/ezytools/VimTools/cvsmenu.txt
VIM_PLUGIN_HELPFILES="cvsmenu.txt"

RDEPEND="dev-vcs/cvs"
