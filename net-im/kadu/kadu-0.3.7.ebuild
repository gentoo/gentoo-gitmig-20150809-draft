# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.3.7.ebuild,v 1.4 2005/03/18 15:11:32 sekretarz Exp $

MY_P=${P/_/-}
DESCRIPTION="QT version of popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"
SRC_URI="http://kadu.net/download/stable/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"

IUSE="kde debug voice extramodules"

DEPEND=">=x11-libs/qt-3.0.1
	kde? ( kde-base/arts )"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf

	use voice && myconf="${myconf} --enable-voice"
	use extramodules && myconf="${myconf} --enable-modules"
	use debug && myconf="${myconf} --enable-debug"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die
}
