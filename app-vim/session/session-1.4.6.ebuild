# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/session/session-1.4.6.ebuild,v 1.1 2011/06/10 20:26:17 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: extended session management for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3150
	http://peterodding.com/code/vim/session/"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15803 -> ${P}.zip"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

VIM_PLUGIN_HELPFILES="session.txt"

S=${WORKDIR}

src_prepare() {
	# remove unneeded files
	rm -f *.md
}
