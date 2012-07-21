# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.26.1.ebuild,v 1.3 2012/07/21 16:37:50 pacho Exp $

EAPI=4

inherit eutils autotools
DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://gpsim.sourceforge.net"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc gtk static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/popt
	>=dev-embedded/gputils-0.12
	gtk? ( >=x11-libs/gtk+extra-2 )
	sys-libs/readline"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex
	|| ( dev-util/yacc sys-devel/bison )"

DOCS=(ANNOUNCE AUTHORS ChangeLog HISTORY PROCESSORS README README.MODULES TODO)

src_prepare() {
	epatch "${FILESDIR}/gpsim-0.26.1-glib-single-include.patch"
	epatch "${FILESDIR}/gpsim-0.26.1-gtkextra.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gtk gui) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc doc/gpsim.pdf

	# remove useless .la files
	use static-libs || find "${D}" -name '*.la' -exec rm -f '{}' +
}
