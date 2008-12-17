# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-amarok/vdr-amarok-0.0.2.ebuild,v 1.4 2008/12/17 14:15:34 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: amarok frontend"
HOMEPAGE="http://irimi.ir.ohost.de/"
SRC_URI="http://irimi.ir.ohost.de/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"

PATCHES=("${FILESDIR}/${P}-gcc4.3.patch")

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog
	elog "To use this plugin you need to install"
	elog "media-sound/vdramgw on this machine"
	elog "or a machine reachable via network"
}
