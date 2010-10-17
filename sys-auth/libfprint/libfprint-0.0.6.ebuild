# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libfprint/libfprint-0.0.6.ebuild,v 1.1 2010/10/17 00:54:13 xmw Exp $

EAPI=3

DESCRIPTION="library to add support for consumer fingerprint readers"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/${PN/lib/}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X debug examples static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/libusb
	dev-libs/openssl
	media-gfx/imagemagick
	X? ( examples? (
		x11-libs/libX11
		x11-libs/libXv ) )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	local my_conf="$(use_enable examples examples-build)"
	if use X ; then
		my_conf="${my_conf} $(use_enable examples x11-examples-build)"
	fi
	econf ${my_conf} \
		$(use_enable debug debug-log) \
		$(use_enable static-libs static) || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	if use examples ; then
		dobin examples/.libs/{enroll,img_capture,verify{,_live}} || die
		if use X ; then
			dobin examples/.libs/img_capture_continuous || die
		fi
	fi
	dodoc AUTHORS ChangeLog HACKING NEWS README THANKS TODO || die
}
