# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/flexplaylist/flexplaylist-0.4.8.ebuild,v 1.9 2006/05/31 11:11:35 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="Winamp/XMMS like Playlist for Noatun 2"
HOMEPAGE="http://metz.gehn.net/"
SRC_URI="http://metz.gehn.net/files/CurrentSources/${P}.tar.bz2"

SLOT="0"
LICENSE="Artistic-2"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

# If we didn't build kdemultimedia with arts support, then we won't have
# noatun, so depend on arts to make sure we have noatun... it's a hack, but
# it's as good as we can do for now...

DEPEND="|| ( kde-base/noatun >=kde-base/kdemultimedia-3.0 )"
need-kde 3
