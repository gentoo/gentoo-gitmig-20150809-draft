# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-scrobbler/xmms-scrobbler-0.3.1.ebuild,v 1.2 2004/03/25 13:30:21 malverian Exp $

DESCRIPTION="Audioscrobbler plugin for XMMS"
SRC_URI="http://static.audioscrobbler.com:8000/plugins/${P}.tar.bz2"
HOMEPAGE="http://www.audioscrobbler.com/"
LICENSE="LGPL-2.1"
DEPEND="media-sound/xmms
	net-ftp/curl
	media-libs/musicbrainz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"

S="${WORKDIR}/${P}"
src_install () {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
