# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vim-nogui/vim-nogui-5.8.ebuild,v 1.1 2001/06/01 19:43:31 grant Exp $

A="vim-5.8-src.tar.gz vim-5.8-rt.tar.gz"
S=${WORKDIR}/vim-5.8
DESCRIPTION="Handy vi-compatible editor"
SRC_URI="ftp://ftp.home.vim.org/pub/vim/unix/vim-5.8-src.tar.gz
	 ftp://ftp.home.vim.org/pub/vim/unix/vim-5.8-rt.tar.gz"
HOMEPAGE="http://www.vim.org"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2
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
    insinto /root
    newins ${FILESDIR}/vimrc .vimrc
    if [ "`use build`" ] ; then
	rm -r ${D}/usr/share/{man,doc}
	rm -r ${D}/usr/share/vim/vim58/{tutor,doc}
    else
        cd ${D}/usr/share/doc/${PF}
        ln -s ../../vim/vim58/doc ${P}
        insinto /etc/skel
        newins ${FILESDIR}/vimrc .vimrc
    fi
    
    cd ${D}/usr/bin
    ln -s vim vi                         
    dosed "s:/usr/bin/nawk:/usr/bin/awk:" /usr/share/vim/vim58/tools/mve.awk
}




