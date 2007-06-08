# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-autotimeredit/vdr-autotimeredit-0.1.8.ebuild,v 1.2 2007/06/08 10:25:34 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: edit Autotimer on vdradmin by plugin"
HOMEPAGE="http://www.fast-info.de/vdr/autotimeredit/"
SRC_URI="http://www.fast-info.de/vdr/autotimeredit/${P}.tgz
		mirror://vdrfiles/vdr-autotimeredit/${P}.tgz
		mirror://vdrfiles/${PN}/${VDRPLUGIN}-${PV}.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.9"

src_unpack() {
	vdr-plugin_src_unpack

	epatch ${DISTDIR}/${VDRPLUGIN}-${PV}.patch
}
