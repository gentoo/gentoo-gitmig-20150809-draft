# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-gtk/vim-gtk-5.7-r1.ebuild,v 1.1 2000/08/07 11:25:41 achim Exp $

P=vim-gtk-5.7
A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
CATEGORY="app-editors"
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=gtk --enable-max-features --enable-pythoninterp --enable-tclinterp \
	--enable-xim --enable-fontset --with-x
    make
}

src_install() {                              
   into /usr
   cd ${S}/src
   cp vim gvim
   dobin gvim
 
}



