# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.5.3-r2.ebuild,v 1.5 2003/09/08 08:58:42 lanius Exp $
inherit kde-base

use kde && need-kde 3
use kde || DEPEND="$DEPEND >=x11-libs/qt-3*"

S=${WORKDIR}/${P}
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
