# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-10.0.2.ebuild,v 1.1 2005/01/20 21:20:55 chriswhite Exp $

inherit nsplugins eutils rpm

MY_PN="RealPlayer"
DESCRIPTION="Real Media Player"
HOMEPAGE="https://player.helixcommunity.org/2004/downloads/"
SRC_URI="https://helixcommunity.org/download.php/801/${MY_PN}-${PV}.608-20041214.i586.rpm"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="~x86"
IUSE="mozilla"
RDEPEND="!media-video/realplayer
		>=dev-libs/glib-2
		>=x11-libs/pango-1.2
		>=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}"
RESTRICT="nostrip nomirror"

S=${WORKDIR}/usr/local/${MY_PN}

src_install() {
	dodir /opt/${MY_PN}
	mv * ${D}/opt/${MY_PN}

	dodir /usr/bin
	dosym /opt/${MY_PN}/realplay /usr/bin/realplay

	cd ${D}/opt/${MY_PN}/share
	doicon realplay.png
	domenu realplay.desktop

	# mozilla plugin
	if use mozilla ; then
		cd ${D}/opt/${MY_PN}/mozilla
		exeinto /opt/netscape/plugins
		doexe nphelix.so
		inst_plugin /opt/netscape/plugins/nphelix.so
	fi
}
