# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellscore/gkrellscore-0.0.2.ebuild,v 1.4 2002/10/04 06:45:31 vapier Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows scores for many leagues"
SRC_URI="http://ssl.usu.edu/paul/gkrellscore/${MY_P}.tar.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gkrellscore"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellscore.so
	dodoc README COPYING Changelog
}
