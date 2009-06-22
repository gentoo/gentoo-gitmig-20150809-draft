# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/fityk/fityk-0.8.7.ebuild,v 1.1 2009/06/22 18:29:11 bicatali Exp $

EAPI="2"
WX_GTK_VER="2.8"

inherit eutils autotools wxwidgets

DESCRIPTION="General-purpose nonlinear curve fitting and data analysis"
HOMEPAGE="http://www.unipress.waw.pl/fityk/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gnuplot readline wxwidgets"

DEPEND=">=sci-libs/xylib-0.4
	readline? ( sys-libs/readline )
	wxwidgets? ( x11-libs/wxGTK:2.8 )
	dev-libs/boost"

RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )"

src_prepare() {
	# avoid building xylib when 3rdparty is disabled
	epatch "${FILESDIR}"/${P}-3rdparty.patch
	eautoreconf

	has_version ">=dev-libs/boost-1.37" &&
	sed -i 's:impl/directives.i:directives.h:' "${S}/src/optional_suffix.h"
}

src_configure() {
	econf  \
		--disable-3rdparty \
		$(use_enable wxwidgets GUI) \
		$(use_with doc) \
		$(use_with readline)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README TODO || die
	rm -f samples/Makefile*
	insinto /usr/share/doc/${PF}
	use examples && doins -r samples
}
