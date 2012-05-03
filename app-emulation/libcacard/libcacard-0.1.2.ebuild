# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libcacard/libcacard-0.1.2.ebuild,v 1.4 2012/05/03 18:49:07 jdhore Exp $

EAPI=4

DESCRIPTION="Library for emulating CAC cards."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/nss-3.13
	>=sys-apps/pcsc-lite-1.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	# --enable-passthru works only on W$
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}
