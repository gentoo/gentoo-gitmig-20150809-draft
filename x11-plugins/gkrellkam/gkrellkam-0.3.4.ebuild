# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellkam/gkrellkam-0.3.4.ebuild,v 1.7 2002/12/09 04:41:55 manson Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="a Image-Watcher-Plugin for Gkrellm."
SRC_URI="mirror://sourceforge/gkrellkam/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellkam.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellkam.so

	doman gkrellkam-list.5
	dodoc README ChangeLog COPYING example.list Release
}
