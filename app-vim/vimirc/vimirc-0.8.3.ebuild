# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimirc/vimirc-0.8.3.ebuild,v 1.1 2004/04/21 19:24:39 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: IRC Client"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=931"
LICENSE="vim"
KEYWORDS="~x86 ~sparc ~mips ~ppc"

# requires 6.2.412 at runtime. it's not too keen upon console vim, so we'll
# just ask for gvim.
RDEPEND=">=app-editors/gvim-6.2-r8"

pkg_postinst() {
	einfo " "
	einfo "This plugin requires a Vim with perl support enabled. This is"
	einfo "controlled by the 'perl' USE flag."
	einfo " "
}

