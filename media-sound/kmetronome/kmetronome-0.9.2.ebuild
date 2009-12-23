# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmetronome/kmetronome-0.9.2.ebuild,v 1.1 2009/12/23 21:27:14 ssuominen Exp $

EAPI=2
# FIXME. Doesn't work with KDE_LINGUAS added
# KDE_LINGUAS="cs es fr"
inherit kde4-base

DESCRIPTION="MIDI based metronome using ALSA sequencer"
HOMEPAGE="http://kmetronome.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="media-libs/alsa-lib
	x11-libs/qt-dbus:4"

DOCS="AUTHORS ChangeLog NEWS README TODO"
