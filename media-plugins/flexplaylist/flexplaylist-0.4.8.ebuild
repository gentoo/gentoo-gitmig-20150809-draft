# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/flexplaylist/flexplaylist-0.4.8.ebuild,v 1.4 2004/06/24 23:28:16 agriffis Exp $

inherit kde-base

DESCRIPTION="Winamp/XMMS like Playlist for Noatun 2"
SRC_URI="http://metz.gehn.net/files/CurrentSources/${P}.tar.bz2"
HOMEPAGE="http://metz.gehn.net/"
IUSE=""

LICENSE="Artistic-2"
KEYWORDS="x86 ~ppc ~amd64"

need-kde 3

newdepend ">=kde-base/kdemultimedia-3.0"
