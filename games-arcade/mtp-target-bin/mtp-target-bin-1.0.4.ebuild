# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/mtp-target-bin/mtp-target-bin-1.0.4.ebuild,v 1.1 2004/06/19 02:57:33 vapier Exp $

#ECVS_SERVER="cvs.gna.org:/cvs/mtptarget"
#ECVS_MODULE="mtp-target"
#inherit cvs

MY_PN=${PN/-bin}
DESCRIPTION="a Monkey Target clone (six mini-game from Super Monkey Ball)"
HOMEPAGE="http://www.mtp-target.org/"
SRC_URI="http://mtptarget.free.fr/download/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/STLport
	sys-libs/zlib
	dev-libs/libxml2
	virtual/x11
	virtual/opengl
	=media-libs/freetype-2*
	media-libs/jpeg
	>=dev-lang/lua"

S=${WORKDIR}/${MY_PN}

src_install() {
	rm {client,server}/launch.sh

	dodir /opt/${PN}
	cp -a ${S}/* ${D}/opt/${PN}/

	into /opt
	newbin ${FILESDIR}/${PN}.sh ${PN}-client
	dosym ${PN}-client /opt/bin/${PN}-server

	dosym /usr/lib/liblualib.so /opt/${PN}/lib/liblualib50.so.5.0
	dosym /usr/lib/liblua.so /opt/${PN}/lib/liblua50.so.5.0
}
