# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r21.ebuild,v 1.2 2003/03/28 16:51:45 joker Exp $

IUSE="gpm nls perl python ruby tcltk X"
VIMPATCH="411"
inherit vim

DESCRIPTION="Vi IMproved!"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~arm ~mips"
DEPEND=">=app-editors/vim-core-6.1-r5
	sys-libs/libtermcap-compat
	dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"

PROVIDE="virtual/editor"
