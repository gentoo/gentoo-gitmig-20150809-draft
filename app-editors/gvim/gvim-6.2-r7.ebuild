# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.2-r7.ebuild,v 1.5 2004/03/29 15:38:10 pylon Exp $

inherit vim

VIM_VERSION="6.2"
VIM_GENTOO_PATCHES="vim-6.2.069-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-6.2.294-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Graphical Vim"
KEYWORDS="alpha ppc sparc x86 ~amd64 ia64 ~hppa ~mips"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}
	virtual/x11
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2.1 virtual/xft )
		!gtk2? (
			gnome? ( gnome-base/gnome-libs )
			!gnome? ( =x11-libs/gtk+-1.2* )
		)
	)
	!gtk? ( motif? ( x11-libs/openmotif ) )"
