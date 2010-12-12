# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kiwix/kiwix-0.9_alpha7.ebuild,v 1.1 2010/12/12 16:50:40 chithanh Exp $

EAPI=3

inherit autotools multilib versionator

MY_P="${PN}-$(replace_version_separator 2 -)-src"

DESCRIPTION="A ZIM reader, especially for offline web content retrieved from Wikipedia"
HOMEPAGE="http://www.kiwix.org/"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/xz-utils
	dev-lang/perl
	dev-libs/icu
	dev-libs/xapian
	net-libs/libmicrohttpd
	net-libs/xulrunner:1.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9-find-xulrunner.patch
	epatch "${FILESDIR}"/${PN}-0.9-custom-flags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGELOG README || die
}
