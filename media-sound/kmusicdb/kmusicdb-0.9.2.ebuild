# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmusicdb/kmusicdb-0.9.2.ebuild,v 1.3 2004/03/01 05:37:14 eradicator Exp $

inherit kde-base
myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=/usr/kde/3/"
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="KmusicdB is a music collection management software."
SRC_URI="mirror://sourceforge/kmusicdb/${P}beta1.tar.gz"
HOMEPAGE="http://kmusicdb.sourceforge.net/"
KEYWORDS="~x86"

newdepend ">=media-libs/libdbmusic-0.4.1"




