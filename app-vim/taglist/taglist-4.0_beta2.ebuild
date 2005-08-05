# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/taglist/taglist-4.0_beta2.ebuild,v 1.1 2005/08/05 16:02:34 ciaranm Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: ctags-based source code browser"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=273"

LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-util/ctags"

VIM_PLUGIN_HELPFILES="taglist-intro"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.4-ebuilds.patch
	[[ -f plugin/${PN}.vim.orig ]] && rm plugin/${PN}.vim.orig
}

