# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/kwintv/kwintv-0.8.11.ebuild,v 1.5 2002/07/19 10:47:49 seemant Exp $

inherit kde-base || die

need-kde 2.1

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="a KDE application that allows you to watch television."
SRC_URI="http://www.staikos.on.ca/~staikos/kwintv/latest/${P}.tar.bz2"
HOMEPAGE="http://www.kwintv.org"
