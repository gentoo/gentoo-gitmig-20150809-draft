# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3kult/mp3kult-0.7-r3.ebuild,v 1.5 2007/07/11 19:30:24 mr_bones_ Exp $

IUSE=""
ARTS_REQUIRED="yes"

inherit kde

DESCRIPTION="Mp3Kult organizes your mp3/ogg collection in a Mysql database."
HOMEPAGE="http://mp3kult.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3kult/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="virtual/mysql
	>=media-libs/id3lib-3.7.13
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0"
need-kde 3.2
