# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kleansweep/kleansweep-0.2.8.ebuild,v 1.1 2006/09/20 22:39:35 troll Exp $

inherit kde python

IUSE="imagemagick"

DESCRIPTION="KleanSweep allows you to reclaim disk space by finding unneeded files"
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-lang/perl
	imagemagick? ( media-gfx/imagemagick )"
DEPEND="${RDEPEND}
	>=dev-lang/python-2.2.3
	dev-util/scons"

need-kde 3.3

src_compile() {
	local myconf="prefix=`kde-config --prefix`"

	use debug && myconf="${myconf} debug=full"

	scons configure \
		${myconf} || die "configure failed"
	scons || die "compile failed"
}

src_install() {
	DESTDIR="${D}" scons install || die "install failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
