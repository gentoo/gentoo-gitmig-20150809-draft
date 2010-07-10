# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-utils/v4l-utils-0.7.91.ebuild,v 1.2 2010/07/10 20:11:56 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs qt4-r2

DESCRIPTION="Separate libraries ebuild from upstream v4l-utils package"
HOMEPAGE="http://people.fedoraproject.org/~jwrdegoede/"
SRC_URI="http://people.fedoraproject.org/~jwrdegoede/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/libv4l-${PV}
	x11-libs/qt-gui:4
	!media-tv/v4l2-ctl"

S=${WORKDIR}/${P}/utils

src_prepare() {
	epatch "${FILESDIR}"/${P}-respect_make.patch
	rm -rf qv4l2-qt3 || die
}

src_configure() {
	tc-export CC CXX
	cd qv4l2-qt4
	eqmake4 qv4l2.pro
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die

	doicon qv4l2-qt4/qv4l2.png
	make_desktop_entry qv4l2 qv4l2

	newdoc libv4l2util/TODO TODO.libv4l2util || die
	newdoc xc3028-firmware/README README.xc3028-firmware || die
}
