# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.2_pre2.ebuild,v 1.1 2003/04/28 21:17:20 agriffis Exp $

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
DESCRIPTION="Graphical Vim"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-6.2_pre2
	x11-base/xfree
	gtk2? ( >=x11-libs/gtk+-2.1 virtual/xft ) :
		( gnome? ( gnome-base/gnome-libs ) : 
			( gtk? ( =x11-libs/gtk+-1.2* ) :
				( motif? ( virtual/motif ) ) ) )"
