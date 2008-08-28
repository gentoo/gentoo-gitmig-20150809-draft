# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/exheres-syntax/exheres-syntax-99999999.ebuild,v 1.3 2008/08/28 16:57:43 coldwind Exp $

inherit vim-plugin git

DESCRIPTION="vim plugin: exheres format highlighting"
HOMEPAGE="http://www.exherbo.org/"
EGIT_REPO_URI="git://git.exherbo.org/exheres-syntax.git"
unset SRC_URI

LICENSE="vim"
SLOT="0"
IUSE=""
KEYWORDS=""

VIM_PLUGIN_HELPFILES="exheres-syntax"
VIM_PLUGIN_MESSAGES="filetype"

src_unpack() {
	git_src_unpack
	rm .gitignore Makefile
}

src_compile() {
	:
}
