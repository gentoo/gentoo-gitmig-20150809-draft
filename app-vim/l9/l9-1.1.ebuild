# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/l9/l9-1.1.ebuild,v 1.1 2010/10/01 06:18:04 radhermit Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.2"
inherit vim-plugin

DESCRIPTION="vim plugin: library for vim scripts"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3252"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13948 -> ${P}.zip"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="l9"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
