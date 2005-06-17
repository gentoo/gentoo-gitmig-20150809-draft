# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcdio/libcdio-0.73.ebuild,v 1.6 2005/06/17 20:43:20 hansmi Exp $

inherit libtool eutils

DESCRIPTION="A library to encapsulate CD-ROM reading and control"
HOMEPAGE="http://www.gnu.org/software/libcdio/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 sparc x86"
IUSE="cddb minimal"

RDEPEND="!minimal? ( dev-libs/popt )
	cddb? ( >=media-libs/libcddb-0.9.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize --reverse-deps
}

src_compile() {
	econf \
		$(use_enable cddb) \
		$(use_with !minimal cd-drive) \
		$(use_with !minimal cd-info) \
		$(use_with !minimal cdda-player) \
		$(use_with !minimal cd-read) \
		$(use_with !minimal iso-info) \
		$(use_with !minimal iso-read) \
		--disable-vcd-info \
		--disable-dependency-tracking || die
	# had problem with parallel make (phosphan@gentoo.org)
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	preserve_old_lib /usr/$(get_libdir)/libiso9660.so.0
	preserve_old_lib /usr/$(get_libdir)/libiso9660.so.2
	preserve_old_lib /usr/$(get_libdir)/libcdio.so.0.2.0
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libiso9660.so.0
	preserve_old_lib_notify /usr/$(get_libdir)/libiso9660.so.2
	preserve_old_lib_notify /usr/$(get_libdir)/libcdio.so.0.2.0
}

