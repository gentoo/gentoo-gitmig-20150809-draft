# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-powermate/vdr-powermate-0.0.3.ebuild,v 1.3 2006/02/05 19:49:02 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Powermate PlugIn"
HOMEPAGE="http://www.powarman.de/"
SRC_URI="http://home.arcor.de/andreas.regel/files/powermate/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="media-video/vdr"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/${P}-1.3.38.diff"
