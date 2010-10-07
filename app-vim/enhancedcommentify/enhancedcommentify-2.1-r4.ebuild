# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/enhancedcommentify/enhancedcommentify-2.1-r4.ebuild,v 1.8 2010/10/07 03:10:30 leio Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: enhanced comment creation"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=23"
SRC_URI="mirror://gentoo/${P}-r1.tar.bz2"

LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="EnhancedCommentify"

DEPEND="${DEPEND} >=sys-apps/sed-4"
# bug #74897
RDEPEND="!app-vim/ctx"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# gentooy things, bug #79185
	epatch "${FILESDIR}"/${P}-gentooisms.patch
	epatch "${FILESDIR}"/${P}-extra-ft-support.patch
}
