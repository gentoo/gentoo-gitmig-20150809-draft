# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSMPmon/wmSMPmon-3.1.ebuild,v 1.1 2006/04/14 18:19:53 nelchael Exp $

IUSE=""
DESCRIPTION="SMP system monitor dockapp"
HOMEPAGE="http://lancre.ribbrock.org/binabit/wmSMPmon/"
SRC_URI="http://lancre.ribbrock.org/binabit/wmSMPmon/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

S="${WORKDIR}/${P}/${PN}"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i -e "s:^CFLAGS = .*$:CFLAGS = ${CFLAGS}:" Makefile

}

src_install() {

	dobin wmSMPmon
	doman wmSMPmon.1
	dodoc ../Changelog

}
