# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.31.ebuild,v 1.2 2001/07/30 16:25:29 danarmak Exp $
# The orig. author didn't write his name. I (danarmak) added the instructions
# printed from pkg_postinst.

#P=
A=${P}.tar.gz
S=${WORKDIR}/${PN}.0.31
DESCRIPTION="Antiword is a free MS Word reader for Linux and RISC OS"
SRC_URI="http://www.winfield.demon.nl/linux/${A}"
HOMEPAGE="http://www.winfield.demon.nl"

DEPEND="app-text/ghostscript"

src_compile() {

    rm Makefile
    sed -e '/pedantic/d' -e 's/$(CFLAGS)/$(CFLAGS) -D$(DB)/' Makefile.Linux > Makefile
    try make 

}

src_install () {

    exeinto /usr/bin
    doexe antiword kantiword
    cd Docs
    doman antiword.1
    dodoc COPYING ChangeLog FAQ History Netscape QandA ReadMe
    cd ..
    insinto /usr/share/${PN}
    doins Resources/*

}

pkg_postinst() {

    echo "
    For word-to-text conversion, create a symlink from ~/.antiword to
    /usr/share/antiword. Or, copy the directory if you want to customize
    it per-user. What's accessed under ~/.antiword is encoding definitions.
"

}