# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-actuator/vdr-actuator-1.1.1.ebuild,v 1.2 2010/12/30 14:32:41 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: control an linear or horizon actuator attached trough the parallel port"
HOMEPAGE="http://ventoso.org/luca/vdr/"
SRC_URI="http://ventoso.org/luca/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.5.8"
RDEPEND="${DEPEND}"

src_unpack() {
	vdr-plugin_src_unpack

	fix_vdr_libsi_include "${S}/filter.c"
}
