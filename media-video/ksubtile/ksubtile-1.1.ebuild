# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtile/ksubtile-1.1.ebuild,v 1.4 2005/07/28 10:35:54 dholm Exp $

inherit kde

IUSE=""
DESCRIPTION="Utility to edit subtitles in SRT format."
HOMEPAGE="http://ksubtile.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksubtile/${PN}_${PV}-2.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND="media-video/mplayer"

need-kde 3
