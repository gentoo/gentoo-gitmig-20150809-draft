# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.2.ebuild,v 1.4 2009/07/12 22:43:53 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/id3lib
	media-libs/taglib
	<media-libs/libmp4v2-1.9.0
	media-libs/libvorbis
	media-libs/flac[cxx]
	media-libs/musicbrainz:3
	media-libs/tunepimp"
DEPEND="${RDEPEND}"
