# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cctree/cctree-1.51.ebuild,v 1.2 2011/05/20 19:14:31 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: Cscope based source-code browser and code flow analysis tool"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2368
	http://sites.google.com/site/vimcctree/"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="cctree.txt"

RDEPEND="dev-util/cscope"

src_prepare() {
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir "${S}"/doc
	sed -e '/" Name Of File/,/".\+Community/!d' -e 's/^" \?//' \
		-e 's/\(Name Of File: \)\([^.]\+\)\.vim/\1*\L\2.txt*/' \
		plugin/cctree.vim > doc/cctree.txt
}
