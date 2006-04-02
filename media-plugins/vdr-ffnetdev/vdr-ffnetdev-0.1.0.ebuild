# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ffnetdev/vdr-ffnetdev-0.1.0.ebuild,v 1.1 2006/04/02 15:50:28 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder ffnetdev PlugIn"
HOMEPAGE="http://ffnetdev.berlios.de"
SRC_URI="http://download.berlios.de/ffnetdev/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/${P}

DEPEND=">=media-video/vdr-1.3.7
		!media-plugins/vdr-ffnetdev-svn"
# dont remove last line, it will fix a depend problem on gentoo.de overlay cvs