# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellflynn/gkrellflynn-0.6.ebuild,v 1.9 2004/03/26 23:10:05 aliz Exp $

IUSE=""
HOMEPAGE="http://horus.comlab.uni-rostock.de/flynn/"
SRC_URI="http://horus.comlab.uni-rostock.de/flynn/${P}.tar.gz"
DESCRIPTION="A funny GKrellM (1 or 2) load monitor (for Doom(tm) fans)"
KEYWORDS="x86 ~sparc alpha"
DEPEND="app-admin/gkrellm"
SLOT="0"
LICENSE="GPL-2"

src_compile() {

	if [ -f /usr/bin/gkrellm ]
	then
		make gkrellm
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		make gkrellm2
	fi
}

src_install() {

	if [ -f /usr/bin/gkrellm ]
	then
		exeinto /usr/lib/gkrellm/plugins
		doexe gkrellflynn.so
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		exeinto /usr/lib/gkrellm2/plugins ;
		doexe gkrellflynn.so
	fi

	dodoc INSTALL Changelog README COPYING AUTHORS
}
