# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/fung-calc/fung-calc-1.3.2b.ebuild,v 1.6 2004/07/01 11:51:53 eradicator Exp $

IUSE="opengl"

DESCRIPTION="Scientific Graphing Calculator"
HOMEPAGE="http://fung-calc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/zlib-1
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6
	>=kde-base/kdelibs-3.1
	>=x11-libs/qt-3.1
	virtual/libc
	opengl? ( virtual/opengl )
	>=kde-base/kdebase-3.1"

src_compile() {
	addwrite ${QTDIR}/etc/settings
	local myconf
	use opengl || myconf="${myconf} --disable-glgraph"
	# use kde || myconf="${myconf} --disable-kde-app"
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}
