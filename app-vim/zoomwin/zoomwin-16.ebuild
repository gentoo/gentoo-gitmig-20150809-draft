# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/zoomwin/zoomwin-16.ebuild,v 1.2 2004/01/23 15:52:22 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: brief-style window zooming"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=508"
LICENSE="vim"
KEYWORDS="alpha ~sparc ~x86 ~ppc ia64"

function src_unpack() {
	unpack ${A}
	mkdir ${S}/doc || die "can't make doc dir"

	# This plugin uses an 'automatic HelpExtractor' variant. This causes
	# problems for us during the unmerge. Fortunately, sed can fix this
	# for us.
	sed -e '1,/^" HelpExtractorDoc:$/d' \
		${S}/plugin/ZoomWin.vim > ${S}/doc/ZoomWin.txt \
		|| die "help extraction failed"
	sed -i -e '/^" HelpExtractor:$/,$d' ${S}/plugin/ZoomWin.vim \
		|| die "help extract remove failed"
}
