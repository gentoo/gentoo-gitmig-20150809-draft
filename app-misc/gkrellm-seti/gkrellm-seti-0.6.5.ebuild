# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 17.Sept.2001 12.20 CET

P=seti-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a Seti@Home Monitor Plugin for Gkrellm"
SRC_URI="http://xavier.serpaggi.free.fr/seti/${A}"
HOMEPAGE="http://xavier.serpaggi.free.fr/seti"

DEPEND=">=app-admin/gkrellm-0.10.3"

src_compile() {
    try make
}

src_install () {
    exeinto /usr/lib/gkrellm/plugins
    doexe seti.so
    dodoc README ChangeLog COPYING NEWS
}
