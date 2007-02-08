# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.5.12-r3.ebuild,v 1.10 2007/02/08 19:29:24 grobian Exp $

inherit eutils

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="nls"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/libexif-0.5-CAN-2005-0664.patch
	epatch ${FILESDIR}/${PN}-0.5.12-recurse.patch
}

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
