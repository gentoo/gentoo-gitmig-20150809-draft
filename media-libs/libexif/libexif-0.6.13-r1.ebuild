# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.6.13-r1.ebuild,v 1.7 2006/10/17 20:32:37 kloeri Exp $

inherit eutils libtool

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="nls doc"

DEPEND="dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/libexif-0.6.13-doxygen.patch
	epatch "${FILESDIR}/${P}-pkgconfig.patch"

	# The libexif hackers made a goof on the soname versioning.
	sed -i 's/^LIBEXIF_AGE=0$/LIBEXIF_AGE=2/' ${S}/configure
	sed -i 's/^LIBEXIF_REVISION=0$/LIBEXIF_REVISION=2/' ${S}/configure
	sed -i 's/^LIBEXIF_VERSION_INFO=.*$/LIBEXIF_VERSION_INFO=$LIBEXIF_CURRENT:$LIBEXIF_AGE:$LIBEXIF_REVISION/' \
		${S}/configure

	elibtoolize
}

src_compile() {
	econf $(use_enable nls) $(use_enable doc) || die
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
