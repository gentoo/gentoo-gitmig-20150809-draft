# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-actuator/vdr-actuator-1.0.3.ebuild,v 1.1 2006/05/02 18:47:26 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: control an linear or horizon actuator attached trough the parallel port"
HOMEPAGE="http://ventoso.org/luca/vdr/"
SRC_URI="http://ventoso.org/luca/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.47"

src_unpack()
{
	vdr-plugin_src_unpack

	fix_vdr_libsi_include ${S}/filter.c
}

