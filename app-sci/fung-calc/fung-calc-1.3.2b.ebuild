# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/fung-calc/fung-calc-1.3.2b.ebuild,v 1.1 2004/04/18 20:06:34 centic Exp $

IUSE="kde opengl"

DESCRIPTION="Scientific Graphing Calculator"
HOMEPAGE="http://fung-calc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-libs/zlib-1
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6
	>=kde-base/kdelibs-3.1
	>=x11-libs/qt-3.1
	virtual/glibc
	opengl? ( virtual/opengl )
	kde? ( >=kde-base/kdebase-3.1 )"

src_compile() {
	local myconf
	use opengl || myconf="${myconf} --disable-glgraph"
	use kde || myconf="${myconf} --disable-kde-app"
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}
