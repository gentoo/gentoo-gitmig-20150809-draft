# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellscore/gkrellscore-0.0.2.ebuild,v 1.1 2002/04/26 09:55:06 seemant Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows scores for many leagues"
SRC_URI="http://ssl.usu.edu/paul/gkrellscore/${MY_P}.tar.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gkrellscore"

DEPEND=">=app-admin/gkrellm-1.0.6
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellscore.so
	dodoc README COPYING Changelog
}
