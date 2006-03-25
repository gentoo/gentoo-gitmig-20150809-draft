# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.21.2-r1.ebuild,v 1.1 2006/03/25 06:12:50 robbat2 Exp $

inherit gnuconfig autotools

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="http://www.dattalo.com/gnupic/${P}.tar.gz
	doc? ( http://dev.gentoo.org/~puggy/files/gpsim-docs-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="gtk doc"
DEPEND="gtk? ( =x11-libs/gtk+extra-0.99* )
	=dev-libs/glib-1.2*
	>=sys-libs/readline-2.0
	sys-devel/flex"

RDEPEND="${DEPEND}
	>=dev-embedded/gputils-0.12.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	for i in configure.in ; do
		sed -i.orig \
		-e 's,CFLAGS="-g -O2",:,g' \
		-e 's,CXXFLAGS="-g -O2",:,g' \
		${i} ;
	done
	eautoreconf
	gnuconfig_update
	elibtoolize
}

src_compile() {
	econf `use_enable gtk gui` || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# install boring documentation
	dodoc ANNOUNCE AUTHORS ChangeLog HISTORY INSTALL NEWS PROCESSORS
	dodoc README README.EXAMPLES README.MODULES TODO

	# install interesting documentation
	if use doc ; then
		cd ${WORKDIR}/gpsim-docs-${PV}
		dodoc gpsim.pdf gui.pdf
	fi
}
