# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gnome/gkrellm-gnome-0.1.ebuild,v 1.7 2003/06/12 22:23:41 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Gnome hints configuration plugin for gkrellm"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
	gnome-base/gnome-libs"

src_compile() {

	make || die

}

src_install () {

	exeinto /usr/lib/gkrellm/plugins
	doexe src/gkrellm-gnome.so
	dodoc README Changelog COPYRIGHT INSTALL

}
