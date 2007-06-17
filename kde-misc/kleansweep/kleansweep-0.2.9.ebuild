# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kleansweep/kleansweep-0.2.9.ebuild,v 1.2 2007/06/17 07:33:15 philantrop Exp $

inherit kde python

DESCRIPTION="KleanSweep allows you to reclaim disk space by finding unneeded files"
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="imagemagick"

RDEPEND="dev-lang/perl
	imagemagick? ( media-gfx/imagemagick )"
DEPEND="${RDEPEND}
	>=dev-lang/python-2.2.3
	dev-util/scons"

need-kde 3.3

src_compile() {
	local myconf="prefix=`kde-config --prefix`"

	use debug && myconf="${myconf} debug=1"

	scons configure \
		${myconf} || die "configure failed"
	scons || die "compile failed"
}

src_install() {
	DESTDIR="${D}" scons install || die "install failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
