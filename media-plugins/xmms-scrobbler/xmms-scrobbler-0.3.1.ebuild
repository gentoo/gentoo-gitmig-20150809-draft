# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-scrobbler/xmms-scrobbler-0.3.1.ebuild,v 1.5 2004/03/29 21:10:59 dholm Exp $

DESCRIPTION="Audioscrobbler plugin for XMMS"
HOMEPAGE="http://www.audioscrobbler.com/"
SRC_URI="http://static.audioscrobbler.com:8000/plugins/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND="media-sound/xmms
	net-misc/curl
	media-libs/musicbrainz"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
