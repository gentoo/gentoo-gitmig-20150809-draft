# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.4.4.ebuild,v 1.4 2004/03/23 18:47:49 dragonheart Exp $

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="xinerama"
RDEPEND=">=kde-base/kde-3.0
		x11-libs/qt
		sys-libs/zlib
		media-libs/libpng
		dev-embedded/gputils
		app-admin/fam"

# build system uses some perl
DEPEND="${RDEPEND}
		dev-lang/perl
		>=sys-devel/gcc-3*"

S=${WORKDIR}/${P}

src_compile() {
	local myconf
	myconf="`use_with xinerama`"
	econf ${myconf} || die "econf failed"
	emake clean || die "emake clean failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
