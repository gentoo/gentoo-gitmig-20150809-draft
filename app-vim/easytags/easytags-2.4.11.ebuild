# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/easytags/easytags-2.4.11.ebuild,v 1.1 2011/07/12 06:33:54 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: automated tag file generation and syntax highlighting"
HOMEPAGE="http://peterodding.com/code/vim/easytags/"
SRC_URI="https://github.com/xolox/vim-${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	dev-util/ctags"

VIM_PLUGIN_HELPFILES="easytags.txt"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	rm INSTALL.md README.md
}

src_install() {
	vim-plugin_src_install

	# Make scripts executable
	fperms 755 /usr/share/vim/vimfiles/misc/easytags/{normalize-tags,why-so-slow}.py
}
