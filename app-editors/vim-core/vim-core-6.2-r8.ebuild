# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-6.2-r8.ebuild,v 1.1 2004/04/09 14:49:01 agriffis Exp $

inherit vim

VIM_VERSION="6.2"
VIM_ORG_PATCHES="vim-6.2.461-patches.tar.bz2"
VIM_RUNTIME_SNAP="vim-runtime-20040408.tar.bz2"
VIM_GENTOO_PATCHES="vim-6.2.069-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}
	mirror://gentoo/${VIM_RUNTIME_SNAP}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="vim and gvim shared files"
KEYWORDS="~alpha ~hppa ~mips ~ppc ~sparc ~x86 ~amd64 ~ia64 ~s390"
DEPEND="${DEPEND}"  # all the deps for vim-core are in vim.eclass
