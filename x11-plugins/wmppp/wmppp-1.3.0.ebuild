# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmppp/wmppp-1.3.0.ebuild,v 1.13 2007/07/22 04:35:34 dberkholz Exp $

IUSE=""
S=${WORKDIR}/wmppp.app/wmppp
DESCRIPTION="Network monitoring dock.app"
SRC_URI="http://web.cs.mun.ca/~gstarkes/wmaker/dockapps/files/${P}.tar.gz"
HOMEPAGE="http://windowmaker.mezaway.org/" #but this site has been dead for a while ;(

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

src_compile() {
	emake all || die
}

src_install () {
	dobin wmppp
	exeinto /etc/ppp
	doexe getmodemspeed
	dodoc user.wmppprc
	cd ..
	dodoc BUGS CHANGES HINTS README TODO
}
