# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorv/colorv-2.0.2.1.ebuild,v 1.1 2011/07/24 06:12:12 radhermit Exp $

EAPI="4"

inherit vim-plugin

MY_PN="ColorV"
DESCRIPTION="vim plugin: a color tool for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3597"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}"

RDEPEND=">=app-editors/gvim-7.0[python]
	dev-python/pygtk:2"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm -f README*
}
