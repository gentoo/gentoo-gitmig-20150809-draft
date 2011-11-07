# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gist/gist-5.5.ebuild,v 1.1 2011/11/07 21:08:21 radhermit Exp $

EAPI=4

inherit vim-plugin

MY_PN="Gist"
DESCRIPTION="vim plugin: interact with gists (gist.github.com)"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2423"
SRC_URI="https://github.com/vim-scripts/${MY_PN}.vim/tarball/${PV} -> ${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	dev-vcs/git"

VIM_PLUGIN_HELPFILES="Gist.vim"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}.vim-* "${S}"
}

src_prepare() {
	rm README || die
}
