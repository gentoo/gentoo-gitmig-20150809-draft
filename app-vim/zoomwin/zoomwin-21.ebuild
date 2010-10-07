# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zoomwin/zoomwin-21.ebuild,v 1.7 2010/10/07 03:53:51 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: brief-style window zooming"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=508"

LICENSE="vim"
KEYWORDS="alpha ~amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="zoomwin"

function src_unpack() {
	unpack ${A}
	mkdir "${S}"/doc || die "can't make doc dir"

	# This plugin uses an 'automatic HelpExtractor' variant. This causes
	# problems for us during the unmerge. Fortunately, sed can fix this
	# for us.
	sed -e '1,/^" HelpExtractorDoc:$/d' \
		"${S}"/plugin/ZoomWin.vim > "${S}"/doc/ZoomWin.txt \
		|| die "help extraction failed"
	sed -i -e '/^" HelpExtractor:$/,$d' "${S}"/plugin/ZoomWin.vim \
		|| die "help extract remove failed"
}
