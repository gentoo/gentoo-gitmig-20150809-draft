# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vcd/vdr-vcd-0.7.ebuild,v 1.5 2007/07/10 23:09:00 mr_bones_ Exp $

inherit eutils vdr-plugin

DESCRIPTION="vdr plugin to play video cds"

HOMEPAGE="http://vdr.heiligenmann.de/"
SRC_URI=" http://vdr.heiligenmann.de/download/vdr-${VDRPLUGIN}-${PV}.tgz
		mirror://vdrfiles/${PN}/vcd-0.7.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

PATCHES="${DISTDIR}/vcd-0.7.patch"

src_unpack() {
	vdr-plugin_src_unpack
	cd "${S}"
	if has_version ">=media-video/vdr-1.5"; then
		epatch "${FILESDIR}/${P}-vdr-1.5.diff"
	fi
}
