# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-actuator/vdr-actuator-1.1.1.ebuild,v 1.4 2011/01/28 17:20:21 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: control an linear or horizon actuator attached trough the parallel port"
HOMEPAGE="http://ventoso.org/luca/vdr/"
SRC_URI="http://ventoso.org/luca/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.8"
RDEPEND="${DEPEND}"

src_unpack() {
	vdr-plugin_src_unpack

	fix_vdr_libsi_include "${S}/filter.c"
}
