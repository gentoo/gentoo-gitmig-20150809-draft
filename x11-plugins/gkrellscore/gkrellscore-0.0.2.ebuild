# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellscore/gkrellscore-0.0.2.ebuild,v 1.8 2003/04/23 00:17:53 lostlogic Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows scores for many leagues"
SRC_URI="http://ssl.usu.edu/paul/gkrellscore/${MY_P}.tar.gz"
HOMEPAGE="http://ssl.usu.edu/paul/gkrellscore"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
	=sys-apps/sed-4*
	>=media-libs/imlib-1.9.10-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:excite:yahoo:g" ${PN}.excite
	mv ${PN}.excite ${PN}.yahoo
	sed -i \
		-e "s:excite:yahoo:g" \
		-e "s:Excite:Yahoo:g" \
		-e 's#\(g_strdup_printf ("http://%s/%s/\)#\1teams#' \
		-e "s:netscape:mozilla:g" \
		-e "s:\(gkrellscore.yahoo\):/usr/share/gkrellm/\1:" \
		${PN}.c
}

src_compile() {

	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellscore.so
	exeinto /usr/share/gkrellm
	doexe ${PN}.yahoo
	dodoc README COPYING Changelog
}
