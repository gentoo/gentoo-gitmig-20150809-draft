# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.5.3-r2.ebuild,v 1.13 2004/07/15 03:52:12 agriffis Exp $

inherit kde

use kde && need-kde 3
use kde || DEPEND="$DEPEND >=x11-libs/qt-3*"

IUSE="kde"
SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

SLOT="3"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {

	local myconfig
	use kde && kde_src_compile myconf
	use kde && myconfig="${myconf}"
	use kde || myconfig="--with-kde=no --prefix=/usr --host=${CHOST} \
	--with-x --enable-mitshm --with-xinerama --with-qt-dir=${QTDIR}	\
	--enable-mt --disable-debug --without-debug"
	./configure ${myconfig} || die
	emake || die
}
