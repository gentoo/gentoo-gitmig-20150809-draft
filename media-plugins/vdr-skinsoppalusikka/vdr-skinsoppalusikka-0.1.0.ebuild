# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/vdr-skinsoppalusikka-0.1.0.ebuild,v 1.1 2006/04/16 18:23:51 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.45"

S=${WORKDIR}/skinsoppalusikka-${PV}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/skinsoppalusikka/logos
	doins ${S}/logos/*.xpm

	insinto /etc/vdr/themes
	doins ${S}/themes/*
}
