# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.21.11-r1.ebuild,v 1.4 2007/01/05 06:45:54 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz
	doc? ( http://dev.gentoo.org/~puggy/files/gpsim-docs-0.21.2.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 x86"

IUSE="doc gtk"

RDEPEND="dev-libs/glib
	dev-libs/popt
	sys-libs/readline
	gtk? ( >=x11-libs/gtk+extra-2.1.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex"
RDEPEND="${RDEPEND}
	>=dev-embedded/gputils-0.12.0"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-eXdbm.patch"
	epatch "${FILESDIR}/gpsim-0.21.11-ktechlab.patch"
	epatch "${FILESDIR}/gpsim-0.21.11-nogui.patch"
	epatch "${FILESDIR}/gpsim-0.21.11-gtk2.diff"
	eautoreconf
}

src_compile() {
	econf $(use_enable gtk gui) || die
	emake || die
}



src_install() {
	emake DESTDIR=${D} install || die

	# install boring documentation
	dodoc ANNOUNCE AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS PROCESSORS
	dodoc README README.EXAMPLES README.MODULES TODO

	# install interesting documentation
	if use doc ; then
		cd ${WORKDIR}/gpsim-docs-0.21.2
		dodoc gpsim.pdf gui.pdf
	fi
}
