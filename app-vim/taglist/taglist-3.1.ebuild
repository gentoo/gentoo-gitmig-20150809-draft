# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/taglist/taglist-3.1.ebuild,v 1.3 2004/01/09 23:26:01 agriffis Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: ctags-based source code browser"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=273"

LICENSE="vim"
KEYWORDS="x86 alpha sparc"

RDEPEND="dev-util/ctags"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/taglist-2.6-exuberant.patch || die "epatch failed"
	rm -f plugin/taglist.vim.orig
}
