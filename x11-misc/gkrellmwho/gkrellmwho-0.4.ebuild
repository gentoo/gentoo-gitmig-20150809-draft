# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@rocketmail.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmwho/gkrellmwho-0.4.ebuild,v 1.1 2002/02/20 02:25:57 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gkrellm plugin which displays users logged in"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins"

DEPEND=">=app-admin/gkrellm-1.0.6"

src_compile() {
    emake
}

src_install () {
    exeinto /usr/lib/gkrellm/plugins
    doexe gkrellmwho.so
    dodoc README 
}
