# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.7-r2.ebuild,v 1.3 2000/11/30 23:14:35 achim Exp $

A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"
DEPEND=">=sys-libs/gpm-1.19.3"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-gui=no --without-x
    # Parallel make does not work
    try make 
}

src_install() { 
    try make prefix=${D}/usr STRIP=echo install
    dodoc README*

    cd ${D}/usr/doc/vim-nogui-5.7-r2
    ln -s ../../share/vim/vim57/doc ${P}
  
    cd ${D}/usr/bin
    ln -s vim vi                         
    dosed "s:/usr/bin/nawk:/usr/bin/awk:" /usr/share/vim/vim57/tools/mve.awk
}




