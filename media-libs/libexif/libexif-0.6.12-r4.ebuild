# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.6.12-r4.ebuild,v 1.11 2006/09/04 04:51:06 kumba Exp $

inherit eutils

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-86740.patch
	epatch ${FILESDIR}/${PN}-0.6.12-recurse.patch

	# The libexif hackers made a goof on the soname versioning.  It will
	# be fixed in 0.6.13 at which point LIBEXIF_AGE should be removed here.
	sed -i 's/^LIBEXIF_AGE=0$/LIBEXIF_AGE=2/' ${S}/configure
	sed -i 's/^LIBEXIF_REVISION=0$/LIBEXIF_REVISION=2/' ${S}/configure
	sed -i 's/^LIBEXIF_VERSION_INFO=.*$/LIBEXIF_VERSION_INFO=$LIBEXIF_CURRENT:$LIBEXIF_AGE:$LIBEXIF_REVISION/' \
		${S}/configure

	# Fix gcc4 build
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include/libexif
	use nls && dodir /usr/share/locale
	dodir /usr/$(get_libdir)/pkgconfig

	make DESTDIR="${D}" install || die

	dodoc ChangeLog README

	# installs a blank directory for whatever broken reason
	use nls || rm -rf ${D}/usr/share/locale

	# Keep around old lib
	preserve_old_lib /usr/$(get_libdir)/libexif.so.9
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libexif.so.9
}
