# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmusicdb/kmusicdb-0.11.0.ebuild,v 1.7 2004/09/14 16:37:36 eradicator Exp $

inherit kde

DESCRIPTION="KmusicdB is a music collection management software."
HOMEPAGE="http://kmusicdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmusicdb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc"
IUSE=""

DEPEND=">=media-libs/libdbmusic-0.7.0"
need-kde 3

myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=/usr/kde/3/"
