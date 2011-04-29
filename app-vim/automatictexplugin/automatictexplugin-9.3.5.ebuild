# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/automatictexplugin/automatictexplugin-9.3.5.ebuild,v 1.1 2011/04/29 03:46:31 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

MY_P="AutomaticTexPlugin_${PV}"
DESCRIPTION="vim plugin: a comprehensive plugin for editing LaTeX files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2945"
SRC_URI="mirror://sourceforge/atp-vim/${MY_P}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

VIM_PLUGIN_HELPFILES="automatic-tex-plugin.txt"

RDEPEND="!app-vim/vim-latex
	dev-tex/latexmk
	app-text/wdiff"
