# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmouse/gkrellmouse-0.0.2.ebuild,v 1.2 2002/05/23 06:50:20 seemant Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin that tracks the total distance of mouse movements"
SRC_URI="http://ssl.usu.edu/paul/gkrellmouse/${MY_P}.tar.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gkrellmouse"

DEPEND=">=app-admin/gkrellm-1.0.6
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkmouse.so
	dodoc README COPYING Changelog
}
