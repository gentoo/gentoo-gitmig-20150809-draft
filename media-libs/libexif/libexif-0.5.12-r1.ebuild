# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.5.12-r1.ebuild,v 1.10 2005/01/23 20:09:48 j4rg0n Exp $

inherit eutils

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64 ~ppc-macos"
IUSE="nls"

DEPEND="dev-util/pkgconfig"
RDEPEND="virtual/libc"

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include/libexif
	dodir /usr/share/locale
	dodir /usr/$(get_libdir)/pkgconfig
	einstall || die

	dodoc ChangeLog README

	# installs a blank directory for whatever broken reason
	use nls || rmdir ${D}/usr/share/locale
}

pkg_postinst() {
	einfo
	einfo "if you've upgraded from ${PN}-0.5.8 you'll"
	einfo "have to run revdep-rebuild from gentoolkit"
	einfo
}
