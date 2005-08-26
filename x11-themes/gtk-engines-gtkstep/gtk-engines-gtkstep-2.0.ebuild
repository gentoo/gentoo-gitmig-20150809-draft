# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-gtkstep/gtk-engines-gtkstep-2.0.ebuild,v 1.2 2005/08/26 13:49:39 agriffis Exp $

inherit gnuconfig

MY_PN="gtkstep"
DESCRIPTION="GTK+1 GTKStep Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/gtkstep_/"
SRC_URI="http://download.freshmeat.net/themes/${MY_PN}_/${MY_PN}_-1.2.x.tar.gz"

KEYWORDS="alpha amd64 hppa ~ia64 ppc sparc x86"
LICENSE="GPL-2"
SLOT="1"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS NEWS README
}
