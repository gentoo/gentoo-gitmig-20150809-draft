# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimpress/vimpress-2.1.0.ebuild,v 1.1 2011/06/10 21:12:51 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: manage wordpress blogs from vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3510"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15764 -> ${P}.zip"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	dev-python/markdown"

VIM_PLUGIN_HELPFILES="vimpress.txt"

S=${WORKDIR}
