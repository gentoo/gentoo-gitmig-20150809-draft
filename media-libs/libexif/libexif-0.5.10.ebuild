# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.5.10.ebuild,v 1.4 2003/09/09 17:25:19 mholzer Exp $

inherit flag-o-matic

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Library for parsing, editing, and saving EXIF data"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="dev-util/pkgconfig"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	dodir /usr/lib
	dodir /usr/include/libexif
	dodir /usr/share/locale
	dodir /usr/lib/pkgconfig
	einstall || die

	dodoc ChangeLog README
}

pkg_postinst() {
	einfo
	einfo "if you've upgraded from ${PN}-0.5.8 you'll"
	einfo "have to run revdep-rebuild from gentoolkit"
	einfo
}
