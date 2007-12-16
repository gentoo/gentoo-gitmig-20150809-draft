# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vcd/vdr-vcd-0.7.ebuild,v 1.6 2007/12/16 13:43:58 hd_brummy Exp $

inherit eutils vdr-plugin

DESCRIPTION="VDR plugin: play video cds"

HOMEPAGE="http://vdr.heiligenmann.de/vdr/"
SRC_URI=" http://www.heiligenmann.de/vdr/download/${P}.tgz
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
