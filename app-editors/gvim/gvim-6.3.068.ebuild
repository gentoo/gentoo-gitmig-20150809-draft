# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.3.068.ebuild,v 1.1 2005/03/25 03:28:35 ciaranm Exp $

inherit vim

VIM_VERSION="6.3"
VIM_GENTOO_PATCHES="vim-${PV}-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-${PV}-patches.tar.bz2"
GVIMRC_FILE_SUFFIX="-r1"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="GUI version of the Vim text editor"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="${IUSE} gnome gtk gtk2 motif nls"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}
	virtual/x11
	gtk? (
		gtk2? (
			>=x11-libs/gtk+-2.2
			virtual/xft
			gnome? ( >=gnome-base/libgnomeui-2.6 )
		)
		!gtk2? (
			gnome? ( gnome-base/gnome-libs )
			!gnome? ( =x11-libs/gtk+-1.2* )
		)
	)
	!gtk? ( motif? ( x11-libs/openmotif ) )"
