# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/amiwm/amiwm-0.20_p48.ebuild,v 1.9 2007/12/09 18:05:27 coldwind Exp $

inherit eutils

MY_P="${PN}${PV/_p/pl}"
DESCRIPTION="Windowmanager ala Amiga(R) Workbench(R)"
HOMEPAGE="http://www.lysator.liu.se/~marcus/amiwm.html"
SRC_URI="ftp://ftp.lysator.liu.se/pub/X11/wm/amiwm/${MY_P}.tar.gz"

LICENSE="amiwm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-flex.patch #110169
}

src_install() {
	dodir /usr/bin
	einstall || die

	rm "${D}"/usr/bin/requestchoice
	dosym /usr/lib/amiwm/requestchoice /usr/bin/requestchoice

	dosed /usr/lib/amiwm/{Xinitrc,Xsession,Xsession2}

	dodoc INSTALL README*

	exeinto /etc/X11/Sessions
	echo "/usr/bin/amiwm" > "${T}"/amiwm
	doexe "${T}"/amiwm
}
