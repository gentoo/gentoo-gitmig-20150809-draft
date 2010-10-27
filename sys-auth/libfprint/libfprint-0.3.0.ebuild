# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libfprint/libfprint-0.3.0.ebuild,v 1.1 2010/10/27 09:38:00 xmw Exp $

EAPI=3

inherit autotools versionator

MY_PV="v_$(replace_all_version_separators _)"
DESCRIPTION="library to add support for consumer fingerprint readers"
HOMEPAGE="http://cgit.freedesktop.org/libfprint/libfprint/"
SRC_URI="http://cgit.freedesktop.org/${PN}/${PN}/snapshot/${MY_PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X debug +examples static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/libusb:1
	dev-libs/nss
	x11-libs/gtk+
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	X? ( examples? (
		x11-libs/libXext
		x11-libs/libXv ) )"

DEPEND="${DEPEND}
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
	local my_conf="$(use_enable examples examples-build)"
	if use X ; then
		my_conf="${my_conf} $(use_enable examples x11-examples-build)"
	else
		my_conf="${my_conf} --disable-x11-examples-build"
	fi
	econf ${my_conf} \
		$(use_enable debug debug-log) \
		$(use_enable static-libs static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use examples ; then
		dobin examples/{enroll,img_capture,verify{,_live}} || die
		if use X ; then
			dobin examples/img_capture_continuous || die
		fi
	fi
	dodoc AUTHORS HACKING NEWS README THANKS TODO || die
}
