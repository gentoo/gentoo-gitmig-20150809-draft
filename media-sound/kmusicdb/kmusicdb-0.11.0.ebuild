# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmusicdb/kmusicdb-0.11.0.ebuild,v 1.9 2005/01/25 18:19:51 greg_g Exp $

inherit kde

DESCRIPTION="KmusicdB is a music collection management software."
HOMEPAGE="http://kmusicdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmusicdb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc"
IUSE=""

DEPEND=">=media-libs/libdbmusic-0.7.0"
RDEPEND="${DEPEND}"
need-kde 3

src_compile() {
	myconf="--with-pqdir=/usr/include --with-qtdir=${QTDIR} --with-kdedir=${KDEDIR}"

	kde_src_compile
}
