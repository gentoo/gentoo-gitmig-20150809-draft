# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exif/exif-0.6.9.ebuild,v 1.8 2007/11/24 22:05:20 ranger Exp $

inherit flag-o-matic

IUSE="nls"

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
SRC_URI="mirror://sourceforge/libexif/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc ~ppc-macos sparc x86"
SLOT="0"

DEPEND="dev-util/pkgconfig
		dev-libs/popt
		>=media-libs/libexif-0.6.9"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf}
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README
}
