# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.4.0.ebuild,v 1.5 2004/06/25 00:43:04 agriffis Exp $

inherit kde
need-kde 3
DESCRIPTION="KPlayer is a KDE media player based on mplayer."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.sourceforge.net/projects/kplayer"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""
newdepend "media-video/mplayer"

