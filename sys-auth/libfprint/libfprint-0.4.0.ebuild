# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libfprint/libfprint-0.4.0.ebuild,v 1.4 2012/02/13 23:44:14 xmw Exp $

EAPI=4

inherit autotools

MY_PV="v_${PV//./_}"
DESCRIPTION="library to add support for consumer fingerprint readers"
HOMEPAGE="http://cgit.freedesktop.org/libfprint/libfprint/"
SRC_URI="http://cgit.freedesktop.org/${PN}/${PN}/snapshot/${MY_PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

RDEPEND="dev-libs/libusb:1
	dev-libs/nss
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] x11-libs/gdk-pixbuf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_PV}

src_prepare() {
	mkdir m4 || die
	eautoreconf
}

pkg_setup() {
	einfo
	elog "This version does not support fdu2000 and upektc (yet)."
	einfo
}

src_configure() {
	econf \
		$(use_enable debug debug-log) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	use static-libs || find "${D}" -name "*.la" -delete
	dodoc AUTHORS HACKING NEWS README THANKS TODO
}
