# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="a Program-Launcher Plugin for Gkrellm"
SRC_URI="http://prdownloads.sourceforge.net/gkrellmlaunch/${A}"
HOMEPAGE="http://gkrellmlaunch.sourceforge.net/"

DEPEND=">=app-admin/gkrellm-1.2.1"

src_compile() {
    make || die
}

src_install () {
    exeinto /usr/lib/gkrellm/plugins
    doexe gkrellmlaunch.so
    dodoc README  
}
