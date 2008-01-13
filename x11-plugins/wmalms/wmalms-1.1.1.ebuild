# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmalms/wmalms-1.1.1.ebuild,v 1.1 2008/01/13 05:21:33 drac Exp $

inherit autotools eutils

DESCRIPTION="lm_sensors monitoring docklet."
HOMEPAGE="http://www.geocities.com/wmalms"
SRC_URI="http://www.geocities.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libX11
	sys-apps/lm_sensors"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	eautoconf
}

src_install() {
	dobin ${PN}
	dodoc README
	dohtml manual.html
}
