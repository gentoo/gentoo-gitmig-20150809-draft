# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r20.ebuild,v 1.1 2003/03/13 22:18:23 seemant Exp $

IUSE="nls perl python ruby tcltk gpm X"

VIMPATCH="390"

EXCLUDE_PATCH="093 100 119 121 126 138 152 164 258 \
304 314 322 334 335 340 346 352 353 354 355 356 374"

use nls || EXCLUDE_PATCH="${EXCLUDE_PATCH} 295 301"

inherit vim

DESCRIPTION="Vi IMproved!"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm"
DEPEND="app-editors/vim-core
	sys-libs/libtermcap-compat
	dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"
#	tcltk?	( dev-lang/tcl )"

PROVIDE="virtual/editor"
