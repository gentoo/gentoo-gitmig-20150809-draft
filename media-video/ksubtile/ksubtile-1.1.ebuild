# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtile/ksubtile-1.1.ebuild,v 1.1 2005/02/01 15:19:15 greg_g Exp $

inherit kde

IUSE=""
DESCRIPTION="Utility to edit subtitles in SRT format."
HOMEPAGE="http://ksubtile.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksubtile/${PN}_${PV}-2.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="media-video/mplayer"

need-kde 3
