# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/vdr-skinsoppalusikka-0.0.6.ebuild,v 1.3 2006/04/17 17:11:56 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.27"

S=${WORKDIR}/skinsoppalusikka-${PV}

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	sed -e 's/VDRVERSNUM < 10345/VDRVERSNUM < 10327/' -i skinsoppalusikka.c

	if has_version "<media-video/vdr-1.3.44"; then
		epatch "${FILESDIR}/${P}-pre-vdr-1.3.44.diff"
		sed -i i18n.c -e '/Czech/d'
	fi
}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/skinsoppalusikka/logos
	doins ${S}/logos/*.xpm

	insinto /etc/vdr/themes
	doins ${S}/themes/*
}
