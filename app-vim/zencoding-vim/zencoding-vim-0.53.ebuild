# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zencoding-vim/zencoding-vim-0.53.ebuild,v 1.2 2011/10/08 16:17:51 phajdan.jr Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: HTML and CSS hi-speed coding"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2981 http://mattn.github.com/zencoding-vim/"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=14850 -> ${P}.zip"
LICENSE="BSD"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
