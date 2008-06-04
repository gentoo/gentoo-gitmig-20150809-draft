# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tinyos/tos-uisp/tos-uisp-1.1.15.ebuild,v 1.4 2008/06/04 17:06:43 flameeyes Exp $

inherit autotools

CVS_MONTH="Dec"
CVS_YEAR="2005"
MY_P="tinyos"

DESCRIPTION="The TinyOS uisp, a tool for AVR which can interface to in-system programmers"
HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs.tar.gz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="!dev-embedded/uisp"
RDEPEND="!dev-embedded/uisp"

S=${WORKDIR}/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs/tools/src/uisp

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:AM_INIT_AUTOMAKE(uisp, 20050519tinyos):AM_INIT_AUTOMAKE(tos-uisp, ${PV}):" configure.in

	eautoreconf
}

src_install() {
	INSTALL_MASK=/usr/share/doc/uisp-20050519tinyos
	emake DESTDIR="${D}" install || die "install failed"
	dodoc doc/* AUTHORS ChangeLog CHANGES TODO
}
