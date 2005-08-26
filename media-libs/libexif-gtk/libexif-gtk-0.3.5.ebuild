# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif-gtk/libexif-gtk-0.3.5.ebuild,v 1.2 2005/08/26 21:45:37 agriffis Exp $

inherit flag-o-matic eutils

IUSE="nls"

DESCRIPTION="GTK frontend to the libexif library (parsing, editing, and saving EXIF data)"
SRC_URI="mirror://sourceforge/libexif/${P}.tar.gz"
HOMEPAGE="http://libexif.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND="dev-util/pkgconfig
		>=x11-libs/gtk+-2.0
		>=media-libs/libexif-0.5.9"

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die

	# Keep around old lib
	preserve_old_lib /usr/$(get_libdir)/libexif-gtk.so.4
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libexif-gtk.so.4
}

