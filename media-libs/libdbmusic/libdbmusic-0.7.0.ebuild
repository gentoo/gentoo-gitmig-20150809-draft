# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdbmusic/libdbmusic-0.7.0.ebuild,v 1.7 2004/09/01 16:58:03 eradicator Exp $

inherit kde

DESCRIPTION="libmusicdb is a wrapper library allowing you to \
interface a libdbmusic database to any program."
HOMEPAGE="http://kmusicdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmusicdb/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc"
IUSE=""

DEPEND=">=dev-db/postgresql-7.2.0
	>=dev-cpp/libpqpp-4.0-r1"

need-kde 3

myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=${KDEDIR}"
