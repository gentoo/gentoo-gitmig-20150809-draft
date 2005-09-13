# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmnote/libmnote-0.5.6.ebuild,v 1.10 2005/09/13 19:55:47 agriffis Exp $

inherit flag-o-matic

IUSE="nls"

DESCRIPTION="libmnote is a library for parsing, editing, and saving MakerNote-EXIF-tags."
SRC_URI="mirror://sourceforge/libexif/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha ppc ~sparc x86"

DEPEND="dev-util/pkgconfig
	>=media-libs/libexif-0.5.9"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dodir /usr/lib
	dodir /usr/include/libmnote
	dodir /usr/share/locale
	dodir /usr/lib/pkgconfig
	einstall || die
}
