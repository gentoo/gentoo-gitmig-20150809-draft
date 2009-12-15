# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmalms/wmalms-1.1.1-r1.ebuild,v 1.5 2009/12/15 17:44:56 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="lm_sensors monitoring docklet."
HOMEPAGE="http://wmalms.tripod.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libX11
	<sys-apps/lm_sensors-3"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
	eautoreconf
}

src_compile() {
	econf --docdir="/usr/share/doc/${PF}"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
