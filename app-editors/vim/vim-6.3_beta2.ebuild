# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.3_beta2.ebuild,v 1.6 2004/06/07 20:07:23 ciaranm Exp $

inherit vim

VIM_VERSION="6.3b"
VIM_GENTOO_PATCHES="vim-6.2.070-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-6.3b.002-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unstable/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/unstable/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vi IMproved!"
KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64 ~ia64 ~arm ~hppa ~ppc64 ~s390"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}"
