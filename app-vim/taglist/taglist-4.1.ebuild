# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/taglist/taglist-4.1.ebuild,v 1.4 2007/07/11 05:14:07 mr_bones_ Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: ctags-based source code browser"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=273"
SRC_URI="http://dev.gentoo.org/~agriffis/dist/${P}.tar.bz2"

LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-util/ctags"

VIM_PLUGIN_HELPFILES="taglist-intro"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.4-ebuilds.patch
	[[ -f plugin/${PN}.vim.orig ]] && rm plugin/${PN}.vim.orig
}
