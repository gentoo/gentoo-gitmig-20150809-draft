# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# $Header: /home/cvsroot/gentoo-x86/gnome-apps/gkrellm-gnome-0.1,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

S=${WORKDIR}/gkrellm-gnome
DESCRIPTION="Gnome hints configuration plugin for gkrellm"
#actual orig archive file is gkrellm-gnome.tar.gz
#portage seems to get file name from SRC_URI
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins.html"

DEPEND="virtual/glibc
	>=app-admin/gkrellm-1.0.4
	>=gnome-base/gnome-core-1.4"

src_compile() {

    try make

}

src_install () {

    exeinto /usr/lib/gkrellm/plugins
    doexe src/gkrellm-gnome.so
    dodoc README Changelog COPYRIGHT INSTALL
}

