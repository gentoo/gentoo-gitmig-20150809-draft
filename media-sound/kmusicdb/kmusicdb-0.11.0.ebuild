# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmusicdb/kmusicdb-0.11.0.ebuild,v 1.3 2004/03/31 18:24:35 eradicator Exp $

inherit kde-base
myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=/usr/kde/3/"
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="KmusicdB is a music collection management software."
SRC_URI="mirror://sourceforge/kmusicdb/${P}.tar.gz"
HOMEPAGE="http://kmusicdb.sourceforge.net/"
KEYWORDS="x86"

newdepend ">=media-libs/libdbmusic-0.7.0"
