# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.3.ebuild,v 1.10 2004/07/19 23:36:38 agriffis Exp $

inherit vim

VIM_VERSION="6.3"
VIM_GENTOO_PATCHES="vim-6.2.070-gentoo-patches.tar.bz2"
# 6.3.000, no patches needed
# VIM_ORG_PATCHES="vim-6.3b.002-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}"
#	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Graphical Vim"
KEYWORDS="x86 sparc mips ppc alpha amd64 ia64 hppa"
IUSE="${IUSE} gnome gtk gtk2 motif nls"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}
	virtual/x11
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2.2 virtual/xft )
		!gtk2? (
			gnome? ( gnome-base/gnome-libs )
			!gnome? ( =x11-libs/gtk+-1.2* )
		)
	)
	!gtk? ( motif? ( x11-libs/openmotif ) )"
