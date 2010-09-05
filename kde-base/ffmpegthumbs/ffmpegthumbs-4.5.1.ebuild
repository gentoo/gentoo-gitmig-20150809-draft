# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ffmpegthumbs/ffmpegthumbs-4.5.1.ebuild,v 1.2 2010/09/05 23:15:44 tampakrap Exp $

EAPI="3"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files."
KEYWORDS=""
IUSE="debug"

DEPEND="
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"
