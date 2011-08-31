# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/notes/notes-0.10-r1.ebuild,v 1.1 2011/08/31 10:15:25 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: easy note taking in vim"
HOMEPAGE="http://peterodding.com/code/vim/notes/"
SRC_URI="https://github.com/xolox/vim-${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-vim/xolox-misc
	|| ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] )"

VIM_PLUGIN_HELPFILES="notes.txt"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	rm INSTALL.md README.md
	rm -rf autoload/xolox/misc
}
