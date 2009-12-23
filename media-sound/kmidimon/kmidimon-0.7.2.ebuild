# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmidimon/kmidimon-0.7.2.ebuild,v 1.1 2009/12/23 21:14:01 ssuominen Exp $

EAPI=2
# FIXME. Doesn't build with KDE_LINGUAS added.
# KDE_LINGUAS="cs es"
inherit kde4-base

DESCRIPTION="A MIDI monitor for ALSA sequencer"
HOMEPAGE="http://kmetronome.sourceforge.net/kmidimon/"
SRC_URI="mirror://sourceforge/kmetronome/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="media-libs/alsa-lib"

DOCS="AUTHORS ChangeLog NEWS README TODO"
