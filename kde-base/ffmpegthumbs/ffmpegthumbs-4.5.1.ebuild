# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ffmpegthumbs/ffmpegthumbs-4.5.1.ebuild,v 1.3 2010/09/06 04:50:46 reavertm Exp $

EAPI="3"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"
