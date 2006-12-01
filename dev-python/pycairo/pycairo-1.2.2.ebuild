# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycairo/pycairo-1.2.2.ebuild,v 1.9 2006/12/01 18:41:41 gustavoz Exp $

inherit eutils autotools

DESCRIPTION="Python wrapper for cairo vector graphics library"
HOMEPAGE="http://cairographics.org/pycairo"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="numeric"

RDEPEND=">=dev-lang/python-2.3
	>=x11-libs/cairo-1.2.0
	numeric? ( dev-python/numeric )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-no-automagic-deps.patch

	eautoreconf
}

src_compile() {
	econf \
		$(use_with numeric) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/*
	rm "${D}"/usr/share/doc/${PF}/examples/Makefile*

	dodoc AUTHORS NOTES README NEWS ChangeLog
}
