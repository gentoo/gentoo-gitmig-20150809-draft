# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-eggtimer/vdr-eggtimer-0.9.5.ebuild,v 1.4 2009/05/07 20:40:15 hd_brummy Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Remind the user on various things (tee, cake, pizza) to be treated after some short time"
HOMEPAGE="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/#eggtimer"
SRC_URI="http://194.95.44.38/~pjuszack/digicam/download/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86 ~amd64"

DEPEND=">=media-video/vdr-1.4.0"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-i18n-fix.diff" )

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins
	doins "${S}/${VDRPLUGIN}.conf"
}
