# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-6.1-r5.ebuild,v 1.2 2003/03/28 16:51:25 joker Exp $

IUSE="gpm nls perl python ruby"
VIMPATCH="411"
inherit vim

DESCRIPTION="vim, gvim and kvim shared files"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~arm ~mips"
DEPEND="dev-util/cscope
	sys-libs/libtermcap-compat
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"
