# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.6.12-r2.ebuild,v 1.1 2005/04/05 02:53:32 eradicator Exp $

inherit eutils

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="nls"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

src_unpack() {
	unpack ${A}

	# The libexif hackers made a goof on the soname versioning.  It will
	# be fixed in 0.6.13 at which point LIBEXIF_AGE should be removed here.
	sed -i 's/^LIBEXIF_AGE=0$/LIBEXIF_AGE=2/' ${S}/configure
	sed -i 's/^LIBEXIF_REVISION=0$/LIBEXIF_REVISION=2/' ${S}/configure
	sed -i 's/^LIBEXIF_VERSION_INFO=.*$/LIBEXIF_VERSION_INFO=$LIBEXIF_CURRENT:$LIBEXIF_AGE:$LIBEXIF_REVISION/' ${S}/configure
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
