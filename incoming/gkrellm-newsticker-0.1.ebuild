# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>

P=gkrellm-newsticker
A=${P}-0.1.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="a Newsticker Plugin for Gkrellm"
SRC_URI="http://www.tu-ilmenau.de/~tisa-in/progs/${A}"
HOMEPAGE="http://www.tu-ilmenau.de/~tisa-in/newsticker.html"

DEPEND=">=app-admin/gkrellm-1.2.1
	>=net-ftp/curl-7.9"

src_compile() {

    make || die

}

src_install () {

    exeinto /usr/lib/gkrellm/plugins
    doexe newsticker.so
    dodoc README  
}
