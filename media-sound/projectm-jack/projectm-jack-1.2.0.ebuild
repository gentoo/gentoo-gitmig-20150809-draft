# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/projectm-jack/projectm-jack-1.2.0.ebuild,v 1.1 2008/07/17 18:10:38 aballier Exp $

inherit cmake-utils

MY_P=${P/m/M}

DESCRIPTION="A Qt based GUI for projectM that visualizes your JACK output."
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit
	>=media-libs/libprojectm-qt-1.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S=${WORKDIR}/${MY_P}
