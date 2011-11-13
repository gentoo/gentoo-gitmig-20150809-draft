# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zencoding-vim/zencoding-vim-0.56.ebuild,v 1.1 2011/11/13 20:04:54 radhermit Exp $

EAPI=4

inherit vim-plugin

MY_PN="ZenCoding.vim"
DESCRIPTION="vim plugin: HTML and CSS hi-speed coding"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2981 http://mattn.github.com/zencoding-vim/"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README || die
}
