# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimbuddy/vimbuddy-0.9.1-r1.ebuild,v 1.1 2005/08/04 22:26:50 ciaranm Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: vimbuddy for the status line"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=8"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=8"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-colon-problems.patch
}

