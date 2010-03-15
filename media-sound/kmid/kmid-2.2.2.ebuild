# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmid/kmid-2.2.2.ebuild,v 1.1 2010/03/15 13:10:53 ssuominen Exp $

EAPI=2
KDE_LINGUAS="cs da de en_GB es fr gl nds pt_BR pt sv uk"
inherit kde4-base

DESCRIPTION="a MIDI/Karaoke player for KDE"
HOMEPAGE="http://userbase.kde.org/KMid2"
SRC_URI="mirror://sourceforge/kmid2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="media-libs/alsa-lib"

DOCS="ChangeLog README TODO"
