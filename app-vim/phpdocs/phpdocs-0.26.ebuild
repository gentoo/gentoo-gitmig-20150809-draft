# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/phpdocs/phpdocs-0.26.ebuild,v 1.2 2003/08/19 02:12:47 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: PHPDoc Support in VIM"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=520"
LICENSE="vim"
KEYWORDS="x86 alpha"
DEPEND="${DEPEND} >=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i 's/$//' ${S}/plugin/phpdoc.vim || die "sed failed"
}
