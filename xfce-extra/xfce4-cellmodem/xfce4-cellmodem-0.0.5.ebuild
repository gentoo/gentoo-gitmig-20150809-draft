# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cellmodem/xfce4-cellmodem-0.0.5.ebuild,v 1.4 2007/08/24 23:23:43 angelos Exp $

inherit autotools eutils xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin for monitoring cellular modems - GPRS/UMTS(3G)/HSDPA(3.5G)"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="sys-apps/pciutils
	>=dev-libs/libusb-0.1.12"
DEPEND="${RDEPEND}
	>=xfce-extra/xfce4-dev-tools-${XFCE_MASTER_VERSION}
	dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
