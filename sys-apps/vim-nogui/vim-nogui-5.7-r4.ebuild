# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.7-r4.ebuild,v 1.2 2001/05/13 11:18:01 achim Exp $

A="vim-5.7-src.tar.gz vim-5.7-rt.tar.gz"
S=${WORKDIR}/vim-5.7
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.7-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

DEPEND=">=sys-libs/ncurses-5.2-r2
        gpm? ( >=sys-libs/gpm-1.19.3 )"
if [ "`use build`" ] ; then
    RDEPEND="virtual/glibc"
fi
src_compile() {

    local myconf

    if [ -z "`use gpm`" ]
    then
      myconf="--disable-gpm"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	 --enable-gui=no --with-cscope --without-x $myconf
    # Parallel make does not work
    if [ "`use build`" ] ; then
        try make LDFLAGS=\"--static\"
    else
	try make
    fi
}

src_install() {

    try make prefix=${D}/usr MANDIR=${D}/usr/share/man STRIP=echo install
    dodoc README*

    if [ "`use build`" ] ; then
	rm -r ${D}/usr/share/{man,vim,doc}
    else
        cd ${D}/usr/share/doc/${PF}
        ln -s ../../vim/vim57/doc ${P}
    fi
  
    cd ${D}/usr/bin
    ln -s vim vi                         
    dosed "s:/usr/bin/nawk:/usr/bin/awk:" /usr/share/vim/vim57/tools/mve.awk
}




