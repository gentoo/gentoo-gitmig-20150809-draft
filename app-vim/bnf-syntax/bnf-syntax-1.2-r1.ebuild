# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bnf-syntax/bnf-syntax-1.2-r1.ebuild,v 1.2 2005/08/10 21:15:36 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: BNF file syntax highlighting"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=250"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for BNF files."

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# fix hi link to use def, bug #101790.
	sed -i -e 's,hi link,hi def link,g' syntax/bnf.vim || die "sed failed"
}

