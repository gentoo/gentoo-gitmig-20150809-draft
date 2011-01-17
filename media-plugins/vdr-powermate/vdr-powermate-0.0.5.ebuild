# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-powermate/vdr-powermate-0.0.5.ebuild,v 1.2 2011/01/17 21:33:56 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Powermate PlugIn"
HOMEPAGE="http://home.arcor.de/andreas.regel/vdr_plugins.htm"
SRC_URI="http://home.arcor.de/andreas.regel/files/powermate/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=media-video/vdr-1.5.8"
DEPEND="${RDEPEND}"
