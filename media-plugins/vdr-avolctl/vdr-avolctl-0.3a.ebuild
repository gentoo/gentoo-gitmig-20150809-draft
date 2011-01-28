# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-avolctl/vdr-avolctl-0.3a.ebuild,v 1.3 2011/01/28 17:26:46 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Change audio volume of alsa-devices based on vdr-volume setting"
HOMEPAGE="http://martins-kabuff.de/avolctl.html"
SRC_URI="http://martins-kabuff.de/download/${P}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6
		>=media-libs/alsa-lib-1.0.8"
