# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/gnome-apps/gkrellm-gnome-0.1,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Gnome hints configuration plugin for gkrellm"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=app-admin/gkrellm-1.2.2-r1
	gnome-base/gnome-libs"

src_compile() {

	make || die

}

src_install () {

	exeinto /usr/lib/gkrellm/plugins
	doexe src/gkrellm-gnome.so
	dodoc README Changelog COPYRIGHT INSTALL

}
