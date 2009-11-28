# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-console/vdr-console-0.6.0.ebuild,v 1.5 2009/11/28 10:57:05 swegener Exp $

inherit vdr-plugin eutils

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows linux console on vdr's output device"
HOMEPAGE="http://ricomp.de/vdr/"
SRC_URI="http://ricomp.de/vdr/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.36"

PATCHES=( "${FILESDIR}"/${P}-vdr-1.3.18.diff
	"${FILESDIR}"/${P}-uint64.diff )

src_unpack() {
	vdr-plugin_src_unpack

	if has_version ">=media-video/vdr-1.5.8" ; then
		ewarn "plugin will not support the new fonthandling"
		epatch "${FILESDIR}/${P}-vdr-1.6.x-compilefix.diff"
	fi
}
