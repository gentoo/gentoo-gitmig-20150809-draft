# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/autoalign/autoalign-4.ebuild,v 1.4 2004/09/06 22:45:24 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: automatically align bib, c, c++, tex and vim code"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=884"
LICENSE="vim"
KEYWORDS="x86 sparc mips ~ppc"
IUSE=""

RDEPEND=">=app-vim/align-28
	>=app-vim/cecutil-3"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Don't use the cecutil.vim included in the tarball, use the one
	# provided by app-vim/cecutil instead.
	rm plugin/cecutil.vim
}

VIM_PLUGIN_HELPTEXT=\
"This plugin will make vim automatically align assignment and similar
statements when editing bib, c, c++, tex or vim code. To disable this
plugin, use :let b:autoalign=0 , and to turn it back on again use
:let b:autoalign=1 ."
