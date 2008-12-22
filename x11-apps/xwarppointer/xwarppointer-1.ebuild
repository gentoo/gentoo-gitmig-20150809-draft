# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xwarppointer/xwarppointer-1.ebuild,v 1.1 2008/12/22 17:41:13 hncaldwell Exp $

DESCRIPTION="Program to move the mouse cursor"
HOMEPAGE="http://www.ishiboo.com/~nirva/Projects/xwarppointer/"
SRC_URI="http://www.ishiboo.com/~nirva/Projects/xwarppointer/${PN}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	sed -i 's:^X11HOME=.*:X11HOME=/usr/X11R6:' \
		Makefile || die 'setting X11HOME failed'

	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe xwarppointer
	dodoc README
}
