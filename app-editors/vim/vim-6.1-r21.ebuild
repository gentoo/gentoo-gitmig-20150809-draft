# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r21.ebuild,v 1.5 2003/04/23 22:05:16 agriffis Exp $

inherit vim

VIM_VERSION="6.1"
VIM_GENTOO_PATCHES="vim-6.1-411-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-6.1-patches-001-411.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-6.1.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-6.1-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vi IMproved!"
KEYWORDS="alpha ~arm hppa ~mips ~ppc sparc x86"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-6.1"
