# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/xquery-syntax/xquery-syntax-0.1-r1.ebuild,v 1.1 2005/08/08 21:59:21 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: XQuery syntax highlighting"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=803"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for XQuery.conf files."

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# use hi def link. Bug #101788, bug #101804.
	sed -i -e 's,^hi link,hi def link,' syntax/xquery.vim || die "sed failed"
}

