# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 16.Sept.2001 23.35 CET

P=gkrellkam-0.2.4
A=gkrellkam_0.2.4.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a Image-Watcher-Plugin for Gkrellm."
SRC_URI="http://prdownloads.sourceforge.net/gkrellkam/${A}"
HOMEPAGE="http://gkrellkam.sourceforge.net"

DEPEND=">=app-admin/gkrellm-1.0.6"


src_compile() {

    try make

}

src_install () {

    exeinto /usr/lib/gkrellm/plugins
    doexe gkrellkam.so
    doman gkrellkam-list.5
    dodoc README ChangeLog COPYING example.list Release
}
