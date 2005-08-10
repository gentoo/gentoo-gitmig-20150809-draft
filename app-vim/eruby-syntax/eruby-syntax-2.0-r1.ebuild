# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/eruby-syntax/eruby-syntax-2.0-r1.ebuild,v 1.1 2005/08/10 21:22:56 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: syntax highlighting for eruby"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=403"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT="This plugin provides syntax highlighting for eruby"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e 's,hi link,hi def link,' syntax/eruby.vim || die "sed failed"
}

