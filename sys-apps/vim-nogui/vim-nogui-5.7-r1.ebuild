# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.7-r1.ebuild,v 1.3 2000/08/16 04:38:32 drobbins Exp $

P=vim-nogui-5.7
A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=no --without-x
    make
}

src_install() { 
    make prefix=${D}/usr install
    prepman
    dodoc README*

    cd ${D}/usr/doc/${P}
    ln -s ../../share/vim/vim57/doc ${P}
    gzip -9 ${D}/usr/share/vim/vim57/doc/*.txt
  
    cd ${D}/usr/bin
    ln -s vim vi                         
 
}




