# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Licensev2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-6.2_pre2.ebuild,v 1.3 2003/08/05 18:17:01 vapier Exp $

inherit vim

VIM_VERSION="6.2b"
VIM_GENTOO_PATCHES="vim-6.2a-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES=""  # no patches available

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unstable/unix/vim-6.2b.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/unstable/extra/vim-6.2b-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}"
#	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="vim, gvim and kvim shared files"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc x86"
DEPEND="${DEPEND}"  # all the deps for vim-core are in vim.eclass
