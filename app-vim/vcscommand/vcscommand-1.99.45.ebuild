# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vcscommand/vcscommand-1.99.45.ebuild,v 1.2 2011/12/11 15:34:41 armin76 Exp $

EAPI=4

inherit vim-plugin

MY_PN="${PN}.vim"
DESCRIPTION="vim plugin: CVS/SVN/SVK/git/bzr/hg integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="!app-vim/cvscommand"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README || die
}
