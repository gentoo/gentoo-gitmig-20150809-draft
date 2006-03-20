# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/vdr-skinsoppalusikka-0.0.4.ebuild,v 1.3 2006/03/20 19:02:54 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka/files/${P}.tgz
	http://www.toms-cafe.de/vdr/download/${VDRPLUGIN}-${PV}-german.diff"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.27"

S=${WORKDIR}/skinsoppalusikka-${PV}

PATCHES="${DISTDIR}/${VDRPLUGIN}-${PV}-german.diff ${FILESDIR}/${PN}-amd64.diff"

src_unpack() {
	vdr-plugin_src_unpack

	has_version "<media-video/vdr-1.3.44" && epatch "${FILESDIR}/${P}-pre-vdr-1.3.44.diff"

}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/skinsoppalusikka/logos
	doins ${S}/logos/*.xpm

	insinto /etc/vdr/themes
	doins ${S}/themes/*
}
