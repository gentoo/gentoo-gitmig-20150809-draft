# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.6.5b.ebuild,v 1.3 2004/06/29 13:26:49 vapier Exp $

inherit kde
need-kde 3
DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="xinerama"

RDEPEND="sys-libs/zlib
	media-libs/libpng
	dev-embedded/gputils
	app-admin/fam"
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
