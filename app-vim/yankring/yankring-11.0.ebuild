# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/yankring/yankring-11.0.ebuild,v 1.1 2011/03/10 10:16:50 radhermit Exp $

EAPI="3"
VIM_PLUGIN_VIM_VERSION="7.2"

inherit vim-plugin

DESCRIPTION="vim plugin: maintains a history of previous yanks and deletes"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1234"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13554 -> ${P}.zip"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

VIM_PLUGIN_HELPFILES="yankring"

S="${WORKDIR}"
