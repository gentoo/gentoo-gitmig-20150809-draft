# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.7-r2.ebuild,v 1.1 2000/09/29 18:17:33 drobbins Exp $

A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=no --without-x
    try make
}

src_install() { 
    try make prefix=${D}/usr install
    prepman
    dodoc README*

    cd ${D}/usr/doc/${P}
    ln -s ../../share/vim/vim57/doc ${P}
  
    cd ${D}/usr/bin
    ln -s vim vi                         
 
}




