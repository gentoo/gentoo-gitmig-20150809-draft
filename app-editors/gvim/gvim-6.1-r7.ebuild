# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.1-r7.ebuild,v 1.2 2003/03/16 03:14:58 seemant Exp $

VIMPATCH="390"

EXCLUDE_PATCH="093 100 119 121 126 138 152 164 258 \
304 314 322 334 335 340 346 352 353 354 355 356 374"

use nls || EXCLUDE_PATCH="${EXCLUDE_PATCH} 295 301"

inherit vim

DESCRIPTION="Graphical Vim"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	app-editors/vim-core
	x11-base/xfree
	gpm?	( >=sys-libs/gpm-1.19.3 )
	gnome?	( gnome-base/gnome-libs )
	gtk?	( =x11-libs/gtk+-1.2* )
	gtk2?	( >=x11-libs/gtk+-2.1
				x11-libs/xft )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"
#	tcltk?	( dev-lang/tcl )"
# It appears that the tclinterp stuff in Vim is broken right now (at
# least on Linux... it works on BSD).  When you --enable-tclinterp
# flag, then the following command never returns:
#
#   VIMINIT='let OS = system("uname -s")' vim
#
# Please don't re-enable the tclinterp flag without verifying first
# that the above works.  Thanks.  (08 Sep 2001 agriffis)

src_unpack() {
	vim_src_unpack

	use gtk2 \
		&& EPATCH_SUFFIX="gz" EPATCH_FORCE="yes" \
			epatch ${WORKDIR}/gentoo/patches-gvim/*
}
