# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-muziczombie/leechcraft-musiczombie-9999.ebuild,v 1.3 2012/12/18 17:39:50 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="MusicBrainz client plugin for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
