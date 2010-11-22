# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gundo/gundo-2.0.0.ebuild,v 1.1 2010/11/22 21:45:24 radhermit Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.3"
inherit vim-plugin

DESCRIPTION="vim plugin: visualize your Vim undo tree"
HOMEPAGE="http://sjl.bitbucket.org/gundo.vim/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	>=dev-lang/python-2.4"

VIM_PLUGIN_HELPFILES="gundo.txt"
