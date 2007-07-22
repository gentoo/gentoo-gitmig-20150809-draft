# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmalms/wmalms-1.0.0a-r1.ebuild,v 1.11 2007/07/22 05:29:19 dberkholz Exp $

IUSE=""
DESCRIPTION="wmalms X-windows hardware sensors applet"
HOMEPAGE="http://www.geocities.com/wmalms"
SRC_URI="http://www.geocities.com/wmalms/wmalms-1.0.0a.tar.gz"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	sys-apps/lm_sensors"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc amd64"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc/${P} install
}
