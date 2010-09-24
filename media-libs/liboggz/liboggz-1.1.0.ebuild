# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liboggz/liboggz-1.1.0.ebuild,v 1.12 2010/09/24 15:36:24 armin76 Exp $

EAPI=2

inherit eutils libtool

DESCRIPTION="Oggz provides a simple programming interface for reading and writing Ogg files and streams"
HOMEPAGE="http://www.annodex.net/software/liboggz"
SRC_URI="http://www.annodex.net/software/liboggz/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="doc test"

RDEPEND="media-libs/libogg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )
	test? ( app-text/docbook-sgml-utils )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.9-destdir.patch"
	elibtoolize #dont drop it!
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
	doman doc/*.1
	use doc || rm -rf "${D}"/usr/share/doc/${PN}
}
