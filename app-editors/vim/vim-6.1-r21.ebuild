# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r21.ebuild,v 1.4 2003/04/16 02:18:01 gmsoft Exp $

IUSE="gpm ncurses nls perl python ruby tcltk X"
VIMPATCH="411"
inherit vim

DESCRIPTION="Vi IMproved!"
KEYWORDS="x86 ~ppc sparc alpha hppa ~arm ~mips"
DEPEND="${DEPEND}
	>=app-editors/vim-core-6.1-r5"

PROVIDE="virtual/editor"
