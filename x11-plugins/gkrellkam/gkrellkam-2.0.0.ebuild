# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellkam/gkrellkam-2.0.0.ebuild,v 1.1 2002/11/08 22:03:45 seemant Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="an Image-Watcher-Plugin for GKrellM2."
SRC_URI="mirror://sourceforge/gkrellkam/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellkam.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe gkrellkam2.so

	doman gkrellkam-list.5
	dodoc README Changelog COPYING example.list Release Todo INSTALL
}
