# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.2_pre1.ebuild,v 1.1 2003/04/23 22:05:16 agriffis Exp $

inherit vim

VIM_VERSION="6.2a"
VIM_GENTOO_PATCHES="vim-6.2a-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES=""  # no patches available for 6.2a

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unstable/unix/vim-6.2a.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/unstable/extra/vim-6.2a-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}"
#	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vi IMproved!"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-6.2_pre1"
