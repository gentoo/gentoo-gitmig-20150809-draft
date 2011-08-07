# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vim-r/vim-r-110805.ebuild,v 1.1 2011/08/07 21:42:54 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

MY_PN="Vim-R-plugin"
DESCRIPTION="vim plugin: integrate vim with R"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2628"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/R
	|| ( app-vim/conque app-vim/screen )"

VIM_PLUGIN_HELPFILES="r-plugin.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README
}
