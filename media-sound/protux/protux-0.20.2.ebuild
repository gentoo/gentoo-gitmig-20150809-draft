# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.20.2.ebuild,v 1.8 2005/10/31 11:13:44 flameeyes Exp $

inherit eutils kde-functions

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://vt.shuis.tudelft.nl/~remon/protux/stable/version-${PV}/${P}.tar.gz"

IUSE="static"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND="virtual/x11
	=x11-libs/qt-3*
	>=media-libs/libmustux-0.20.2"

set-qtdir 3

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_compile() {
	export QT_MOC=${QTDIR}/bin/moc
	econf $(use_enable static) || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README
}
