# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/flexplaylist/flexplaylist-0.4.8.ebuild,v 1.5 2004/06/29 00:33:10 carlo Exp $

inherit kde

DESCRIPTION="Winamp/XMMS like Playlist for Noatun 2"
HOMEPAGE="http://metz.gehn.net/"
SRC_URI="http://metz.gehn.net/files/CurrentSources/${P}.tar.bz2"

SLOT="0"
LICENSE="Artistic-2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=kde-base/kdemultimedia-3.0"
need-kde 3
