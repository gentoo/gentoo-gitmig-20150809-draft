# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.3.6.ebuild,v 1.2 2004/01/07 19:24:54 mholzer Exp $

MY_P=${P/_/-}
DESCRIPTION="KDE version of popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"
SRC_URI="http://kadu.net/releases/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"

IUSE="kde"

DEPEND=">=x11-libs/qt-3.0.1
	kde? ( kde-base/arts )"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die
}
