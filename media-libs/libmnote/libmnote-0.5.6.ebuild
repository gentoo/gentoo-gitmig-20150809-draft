# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmnote/libmnote-0.5.6.ebuild,v 1.4 2003/07/12 18:05:55 aliz Exp $

inherit flag-o-matic

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="libmnote is a library for parsing, editing, and saving MakerNote-EXIF-tags."
SRC_URI="mirror://sourceforge/libexif/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="dev-util/pkgconfig
	>=media-libs/libexif-0.5.9"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	dodir /usr/lib
	dodir /usr/include/libmnote
	dodir /usr/share/locale
	dodir /usr/lib/pkgconfig
	einstall || die
}
