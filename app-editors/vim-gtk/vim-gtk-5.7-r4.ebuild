# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-gtk/vim-gtk-5.7-r4.ebuild,v 1.1 2001/04/19 02:06:01 achim Exp $

P=vim-gtk-5.7
A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

DEPEND="virtual/glibc
        >=sys-libs/gdbm-1.8.0
	>=sys-libs/ncurses-5.2
	>=x11-libs/gtk+-1.2.8
	python? ( virtual/python )
	tcltk? ( >=dev-lang/tcl-tk-8.1.1 )"

RDEPEND="virtual/glibc
	 tcltk? ( >=dev-lang/tcl-tk-8.1.1 )
	 >=x11-libs/gtk+-1.2.8
         gpm? ( >=sys-libs/gpm-1.19.3 )"

src_compile() {
    local myconf
    if [ "`use python`" ]
    then
      myconf="--enable-pythoninterp"
    fi
    if [ "`use tcltk`" ]
    then
      myconf="$myconf --enable-tclinterp"
    fi
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=gtk --enable-max-features \
	--enable-xim --enable-fontset --with-x $myconf
    try make
}

src_install() {
   into /usr
   cd ${S}/src
   cp vim gvim
   dobin gvim

}



