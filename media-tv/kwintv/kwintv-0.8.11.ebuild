# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kwintv/kwintv-0.8.11.ebuild,v 1.3 2003/08/12 03:40:43 caleb Exp $

inherit kde-base

need-kde 2.1


LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="a KDE application that allows you to watch television."
SRC_URI="http://www.staikos.on.ca/~staikos/kwintv/latest/${P}.tar.bz2"
HOMEPAGE="http://www.kwintv.org"

src_unpack()
{
	kde_src_unpack
	cd ${S} && epatch ${FILESDIR}/kwintv.patch
}
