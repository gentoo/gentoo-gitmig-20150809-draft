# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdbmusic/libdbmusic-0.4.1.ebuild,v 1.1 2003/01/31 21:45:33 rphillips Exp $

inherit kde-base
myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=/usr/kde/3/"
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="libmusicdb is a wrapper library allowing you to \
interface a libdbmusic database to any program. "
SRC_URI="mirror://sourceforge/kmusicdb/${P}beta1.tar.gz"
HOMEPAGE="http://kmusicdb.sourceforge.net/"
KEYWORDS="~x86"

newdepend ">=dev-db/postgresql-7.2.0"




