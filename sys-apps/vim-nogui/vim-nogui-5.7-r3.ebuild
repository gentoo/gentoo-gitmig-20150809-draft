# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.7-r3.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

DEPEND=">=sys-libs/ncurses-5.2-r2
        gpm? ( >=sys-libs/gpm-1.19.3 )"

src_compile() {

    local myconf

    if [ -z "`use gpm`" ]
    then
      myconf="--disable-gpm"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	 --enable-gui=no --without-x $myconf
    # Parallel make does not work
    try make
}

src_install() {

    try make prefix=${D}/usr MANDIR=${D}/usr/share/man STRIP=echo install
    dodoc README*

    cd ${D}/usr/share/doc/${PF}
    ln -s ../../vim/vim57/doc ${P}
  
    cd ${D}/usr/bin
    ln -s vim vi                         
    dosed "s:/usr/bin/nawk:/usr/bin/awk:" /usr/share/vim/vim57/tools/mve.awk
}




