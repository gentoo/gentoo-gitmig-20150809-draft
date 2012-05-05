# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisual/libvisual-0.4.0-r2.ebuild,v 1.8 2012/05/05 08:02:29 jdhore Exp $

EAPI=4
inherit eutils

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."
HOMEPAGE="http://libvisual.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0.4"
KEYWORDS="amd64 hppa ~mips ppc ppc64 x86 ~x86-fbsd"
IUSE="debug nls static-libs threads"

RDEPEND="threads? ( dev-libs/glib:2 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-better-altivec-detection.patch \
		"${FILESDIR}"/${P}-inlinedefineconflict.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-shared \
		$(use_enable nls) \
		$(use_enable threads) \
		$(use_enable debug)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
