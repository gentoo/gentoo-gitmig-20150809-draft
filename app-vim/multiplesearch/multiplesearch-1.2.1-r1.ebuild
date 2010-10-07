# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/multiplesearch/multiplesearch-1.2.1-r1.ebuild,v 1.8 2010/10/07 03:24:29 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: allows multiple highlighted searches"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=479"

LICENSE="vim"
KEYWORDS="alpha ~amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="MultipleSearch"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir "${S}"/doc
	sed -e '1,/"-\+$/d' -e '/" -\+$/,9999d' -e 's/^" \?//' \
		-e 's/^\(MultipleSearch\)/*\1*\n\n\1/' \
		plugin/MultipleSearch.vim \
		> doc/${PN}.txt
}
