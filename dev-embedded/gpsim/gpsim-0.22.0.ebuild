# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.22.0.ebuild,v 1.6 2007/06/07 10:08:45 corsair Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

IUSE="doc gtk"

RDEPEND="dev-libs/glib
	dev-libs/popt
	gtk? ( >=x11-libs/gtk+extra-2.1.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	>=dev-embedded/gputils-0.12.0"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-eXdbm.patch"
	eautoreconf
}


src_compile() {
	econf $(use_enable gtk gui) || die "Configuration failed"
	emake || die "Compilation failed"
}


src_install() {
	emake DESTDIR=${D} install || die "Installation failed"

	# install boring documentation
	dodoc AUTHORS ChangeLog HISTORY PROCESSORS README README.MODULES TODO

	# install interesting documentation
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins "${S}"/doc/gpsim.pdf
	fi
}
