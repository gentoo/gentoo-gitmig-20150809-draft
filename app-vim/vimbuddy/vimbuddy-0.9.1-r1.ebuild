# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimbuddy/vimbuddy-0.9.1-r1.ebuild,v 1.8 2007/07/11 05:14:08 mr_bones_ Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: vimbuddy for the status line"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=8"
LICENSE="as-is"
KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=8"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-colon-problems.patch
}
