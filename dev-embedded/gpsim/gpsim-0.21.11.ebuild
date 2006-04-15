# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.21.11.ebuild,v 1.4 2006/04/15 22:57:04 flameeyes Exp $

inherit gnuconfig eutils libtool autotools

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz"
	#doc? ( http://dev.gentoo.org/~puggy/files/gpsim-docs-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="gtk doc"
DEPEND="gtk? ( >=x11-libs/gtk+extra-2 )
	=dev-libs/glib-1.2*
	>=sys-libs/readline-2.0
	sys-devel/flex"

RDEPEND="${DEPEND}
	>=dev-embedded/gputils-0.12.0"

src_unpack() {
	unpack ${A}
	sed -i.orig \
	-e '864s,&& defined HAVE_GUI,,g' \
	-e '774s,#ifdef HAVE_GUI,,g' \
	-e '793s,#endif,,g' \
	${S}/cli/input.cc
	#for i in ${S}/gpsim/Makefile.{in,am} ; do
	#	sed -i.orig -e '/^gpsim_LDFLAGS/s,$, -lpthread,g' $i
	#done
	for i in ${S}/cli/Makefile.{in,am} ; do
		sed -i.orig -e '/^libgpsimcli_la_LDFLAGS/s,$, -lpthread,g' $i
	done
	for i in ${S}/src/Makefile.{in,am} ; do
		sed -i.orig -e '/^libgpsim_la_LDFLAGS/s,$, -lpthread,g' $i
	done

	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"

	eautomake
	elibtoolize
}

src_compile() {
	gnuconfig_update
	econf `use_enable gtk gui` || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

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
