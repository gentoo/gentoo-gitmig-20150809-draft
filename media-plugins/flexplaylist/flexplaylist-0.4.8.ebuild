# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/flexplaylist/flexplaylist-0.4.8.ebuild,v 1.1 2004/05/13 02:51:05 squinky86 Exp $

inherit kde-base

DESCRIPTION="Winamp/XMMS like Playlist for Noatun 2"
SRC_URI="http://metz.gehn.net/files/CurrentSources/${P}.tar.bz2"
HOMEPAGE="http://metz.gehn.net/"
IUSE=""

LICENSE="Artistic-2"
KEYWORDS="~x86"

need-kde 3

newdepend ">=kde-base/kdemultimedia-3.0"
