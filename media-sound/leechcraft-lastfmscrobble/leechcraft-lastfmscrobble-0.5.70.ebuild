# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-lastfmscrobble/leechcraft-lastfmscrobble-0.5.70.ebuild,v 1.4 2012/07/07 10:34:47 johu Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Last.FM scrobbler plugin for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	<media-libs/liblastfm-1.0"
RDEPEND="${DEPEND}"
