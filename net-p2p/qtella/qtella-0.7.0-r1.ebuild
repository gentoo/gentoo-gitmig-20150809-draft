# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.7.0-r1.ebuild,v 1.1 2005/01/29 23:37:27 greg_g Exp $

inherit eutils kde-functions

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

LICENSE="GPL-2"
IUSE="kde"
KEYWORDS="~x86 ~ppc"
SLOT="3" # why??

DEPEND=">=x11-libs/qt-3
	kde? ( >=kde-base/kdelibs-3 )"

export MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	if ! use kde; then
		epatch ${FILESDIR}/${PV}-nokde.patch
	fi
}

src_compile() {
	set-qtdir 3
	set-kdedir 3

	local myconf
	use kde || myconf="--with-kde=no"

	econf ${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
