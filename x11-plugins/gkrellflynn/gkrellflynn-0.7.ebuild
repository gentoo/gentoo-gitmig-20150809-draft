# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellflynn/gkrellflynn-0.7.ebuild,v 1.4 2005/04/27 21:30:53 herbs Exp $

inherit multilib

IUSE=""
HOMEPAGE="http://horus.comlab.uni-rostock.de/flynn/"
SRC_URI="http://horus.comlab.uni-rostock.de/flynn/${P}.tar.gz"
DESCRIPTION="A funny GKrellM (1 or 2) load monitor (for Doom(tm) fans)"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ppc"
DEPEND="app-admin/gkrellm"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	# Clean out precompiled plugin first
	make clean

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
		exeinto /usr/$(get_libdir)/gkrellm/plugins
		doexe gkrellflynn.so
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		exeinto /usr/$(get_libdir)/gkrellm2/plugins ;
		doexe gkrellflynn.so
	fi

	dodoc INSTALL Changelog README COPYING AUTHORS
}
