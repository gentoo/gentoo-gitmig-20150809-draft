# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.21.2.ebuild,v 1.6 2005/01/05 00:31:06 kingtaco Exp $

inherit gnuconfig

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="http://www.dattalo.com/gnupic/${P}.tar.gz
	doc? ( http://dev.gentoo.org/~puggy/files/gpsim-docs-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE="X doc"
DEPEND="X? ( >=x11-libs/gtk+extra-0.99.17 )
	>=sys-libs/readline-2.0
	sys-devel/flex"

RDEPEND="${DEPEND}
	>=dev-embedded/gputils-0.12.0"



src_compile() {
	gnuconfig_update
	econf `use_enable X gui` || die
	emake || die
}



src_install() {
	emake DESTDIR=${D} install || die

	# install boring documentation
	dodoc ANNOUNCE AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS PROCESSORS
	dodoc README README.EXAMPLES README.MODULES TODO

	# install interesting documentation
	if use doc
	then
		cd ${WORKDIR}/gpsim-docs-${PV}
		dodoc gpsim.pdf gui.pdf
	fi
}
