# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-scrobbler/xmms-scrobbler-0.3.5.ebuild,v 1.2 2004/10/10 20:50:26 eradicator Exp $

IUSE=""

DESCRIPTION="Audioscrobbler music-profiling plugin for XMMS"
HOMEPAGE="http://www.audioscrobbler.com/"
SRC_URI="http://static.audioscrobbler.com/plugins/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="media-sound/xmms
	net-misc/curl
	>=media-libs/musicbrainz-2.0.2-r2"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
