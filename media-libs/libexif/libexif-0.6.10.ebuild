# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.6.10.ebuild,v 1.2 2004/09/29 03:09:28 eradicator Exp $

inherit flag-o-matic eutils

IUSE="nls"

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"

DEPEND="dev-util/pkgconfig"
RDEPEND="virtual/libc"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include/libexif
	use nls && dodir /usr/share/locale
	dodir /usr/$(get_libdir)/pkgconfig

	make DESTDIR="${D}" install || die

	# Keep around old lib
	if [ -f /usr/$(get_libdir)/libexif.so.9 ]; then
		cp /usr/$(get_libdir)/libexif.so.9 ${D}/usr/$(get_libdir)
		fperms 755 /usr/$(get_libdir)/libexif.so.9
	fi

	dodoc ChangeLog README

	# installs a blank directory for whatever broken reason
	use nls || rm -rf ${D}/usr/share/locale
}

pkg_postinst() {
	if [ -f /usr/$(get_libdir)/libexif.so.9 ]; then
		einfo "An old version of libexif was detected on your system."
		einfo "In order to avoid conflicts, we've kept the old lib"
		einfo "around.  In order to make full use of the new version"
		einfo "of libexif, you will need to do the following:"
		einfo "  revdep-rebuild --soname libexif.so.9"
		einfo
		einfo "After doing that, you can safely remove /usr/$(get_libdir)/libexif.so.9"
	fi
}
