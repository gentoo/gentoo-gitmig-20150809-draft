# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimpython/vimpython-1.7.ebuild,v 1.3 2004/04/04 00:48:36 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: improvements for editing python scripts"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=30"

LICENSE="vim"
KEYWORDS="sparc ~x86 ~ppc amd64 alpha ia64"

DEPEND="${DEPEND} >=sys-apps/sed-4"

function src_unpack() {
	unpack ${A}
	# We know that we've got *vim >= 6.2, so we can safely enable the
	# function which needs try/catch support.
	sed -i \
		-e '/" function! s:JumpToAndUnfoldWithExceptions/,/^$/s/" \?//' \
		${S}/plugin/python.vim || die "Sed magic failed"
}

