# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.3-r1.ebuild,v 1.7 2004/10/20 14:19:45 hattya Exp $

inherit vim

VIM_VERSION="6.3"
VIM_ORG_PATCHES="vim-6.3.025-patches.tar.bz2"
VIM_GENTOO_PATCHES="vim-6.3.025-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vim, an improved vi-style text editor"
KEYWORDS="x86 sparc mips ppc amd64 alpha ia64 ~arm hppa ~ppc64 s390"
IUSE="${IUSE} nls"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}"
