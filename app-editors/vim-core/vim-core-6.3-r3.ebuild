# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-6.3-r3.ebuild,v 1.5 2004/12/11 20:07:46 gmsoft Exp $

inherit vim

VIM_VERSION="6.3"
VIM_ORG_PATCHES="vim-6.3.045-patches.tar.bz2"
VIM_RUNTIME_SNAP="vim-runtime-20041209.tar.bz2"
VIM_GENTOO_PATCHES="vim-6.3.025-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_RUNTIME_SNAP}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="vim and gvim shared files"
KEYWORDS="x86 sparc mips ~ppc alpha amd64 ~ia64 ~arm hppa ~ppc64 ~s390"
IUSE="${IUSE} nls"
DEPEND="${DEPEND}"  # all the deps for vim-core are in vim.eclass
