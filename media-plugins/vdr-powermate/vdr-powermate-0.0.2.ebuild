# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-powermate/vdr-powermate-0.0.2.ebuild,v 1.1 2005/12/13 20:59:06 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Powermate PlugIn"
HOMEPAGE="http://www.powarman.de/"
SRC_URI="http://home.arcor.de/andreas.regel/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="media-video/vdr"
DEPEND="${RDEPEND}"

src_unpack() {
	vdr-plugin_src_unpack

	if
	    has_version ">=media-video/vdr-1.3.18"
	then
	    epatch ${FILESDIR}/${P}-1.3.18.diff
	fi
}
