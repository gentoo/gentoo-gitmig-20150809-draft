# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.2-r9.ebuild,v 1.14 2004/07/19 23:25:39 agriffis Exp $

inherit vim

VIM_VERSION="6.2"
VIM_GENTOO_PATCHES="vim-6.2.070-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-6.2.517-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vi IMproved!"
KEYWORDS="alpha hppa mips ppc sparc ~x86 amd64 ~ia64 s390 ppc64 arm"
IUSE="${IUSE} nls"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}"
