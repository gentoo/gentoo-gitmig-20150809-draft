# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zencoding-vim/zencoding-vim-0.48.ebuild,v 1.1 2010/11/14 07:05:47 radhermit Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: HTML and CSS hi-speed coding"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2981 http://mattn.github.com/zencoding-vim/"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=14214 -> ${P}.zip"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
