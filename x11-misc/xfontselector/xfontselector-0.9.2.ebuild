# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfontselector/xfontselector-0.9.2.ebuild,v 1.1 2002/05/02 18:13:21 danarmak Exp $

MY_P="xfontselector-0.9-2"
S=${WORKDIR}/${MY_P}
DESCRIPTION="This is a font selector for X, much nicer than xfontsel."
SRC_URI="http://prdownloads.sourceforge.net/xfontselector/${MY_P}.tar.gz"
HOMEPAGE="http://xfontselector.sourceforge.net/"
DEPEND="=x11-libs/qt-2*
	x11-base/xfree
	media-libs/jpeg
	media-libs/lcms
	media-libs/libmng
	media-libs/libpng
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/zlib"

src_compile() {
	patch Makefile ${FILESDIR}/xfontselector-gentoo.diff || die
	emake || die
}

src_install () {
	dobin xfontselector || die
	doman ${FILESDIR}/xfontselector.1
}
