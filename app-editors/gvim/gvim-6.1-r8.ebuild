# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.1-r8.ebuild,v 1.2 2003/04/02 14:40:18 agriffis Exp $

IUSE="gnome gpm gtk gtk2 ncurses nls perl python ruby X"
VIMPATCH="411"
inherit vim

DESCRIPTION="Graphical Vim"
KEYWORDS="x86 ~ppc ~sparc alpha"
DEPEND="${DEPEND}
	>=app-editors/vim-core-6.1-r5
	x11-base/xfree
	gtk2? ( >=x11-libs/gtk+-2.1 virtual/xft ) :
		( gnome? ( gnome-base/gnome-libs ) : 
			( gtk? ( =x11-libs/gtk+-1.2* ) ) )"

src_unpack() {
	vim_src_unpack

	use gtk2 \
		&& EPATCH_SUFFIX="gz" EPATCH_FORCE="yes" \
			epatch ${WORKDIR}/gentoo/patches-gvim/*
}
