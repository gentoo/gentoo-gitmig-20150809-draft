# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-scrobbler/xmms-scrobbler-0.3.3.ebuild,v 1.6 2004/09/15 19:30:44 eradicator Exp $

IUSE=""

DESCRIPTION="Audioscrobbler music-profiling plugin for XMMS"
HOMEPAGE="http://www.audioscrobbler.com/"
SRC_URI="http://static.audioscrobbler.com:8000/plugins/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc"

DEPEND="media-sound/xmms
	net-misc/curl
	>=media-libs/musicbrainz-2.0.2-r2"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
