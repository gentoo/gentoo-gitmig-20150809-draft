# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.4.4.ebuild,v 1.9 2004/06/29 13:26:49 vapier Exp $

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="xinerama"

RDEPEND=">=kde-base/kdelibs-3.0
	x11-libs/qt
	virtual/x11
	sys-libs/zlib
	dev-libs/expat
	sys-devel/gcc
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	media-libs/nas
	sys-devel/gcc
	dev-embedded/gputils
	app-admin/fam
	virtual/libc"
# build system uses some perl
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-devel/gcc-3"

src_compile() {
	econf `use_with xinerama` || die "econf failed"
	emake clean || die "emake clean failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
