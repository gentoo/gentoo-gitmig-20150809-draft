# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-gtk/vim-gtk-5.7-r1.ebuild,v 1.5 2000/11/15 16:33:15 achim Exp $

P=vim-gtk-5.7
A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	>=x11-base/xfree-4.0.1
	|| ( >=sys-devel/python-basic-1.5.2 >=dev-lang/python-1.5.2 )"
#	>=dev-lang/tcl-tk-8.1.1 does not work
src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=gtk --enable-max-features \
	--enable-pythoninterp --enable-tclinterp \
	--enable-xim --enable-fontset --with-x
    try make
}

src_install() {                              
   into /usr
   cd ${S}/src
   cp vim gvim
   dobin gvim
 
}



