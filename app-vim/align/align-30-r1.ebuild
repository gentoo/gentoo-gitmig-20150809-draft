# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/align/align-30-r1.ebuild,v 1.4 2005/02/22 22:25:52 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: commands and maps to help produce aligned text"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=294"

LICENSE="vim"
KEYWORDS="alpha ia64 mips ~ppc sparc x86 amd64"
IUSE=""

VIM_PLUGIN_HELPFILES="align align-maps"

src_unpack() {
	unpack ${A}
	cd ${S}
	# this makes vim7 throw a hissy fit
	sed -i -e 's/ version </ v:version </g' plugin/Align*.vim || die "bad sed"
}

