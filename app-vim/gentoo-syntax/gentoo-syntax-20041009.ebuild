# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gentoo-syntax/gentoo-syntax-20041009.ebuild,v 1.6 2004/11/14 17:15:37 nerdboy Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Gentoo Ebuild, Eclass, GLEP, ChangeLog and Portage
Files syntax highlighting, filetype and indent settings"
HOMEPAGE="http://developer.berlios.de/projects/gentoo-syntax"
LICENSE="vim"
KEYWORDS="x86 sparc mips amd64 ppc ~ppc64 alpha ia64"
IUSE=""
RESTRICT="nomirror"
SRC_URI="http://download.berlios.de/gentoo-syntax/${P}.tar.bz2"

VIM_PLUGIN_HELPFILES="gentoo-syntax"

