# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-industrial/gtk-engines-industrial-0.2.36.ebuild,v 1.7 2007/01/04 19:01:21 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

MY_PN="gtk-industrial-engine"
DESCRIPTION="GTK+ 1 Industrial theme engine"
HOMEPAGE="http://art.gnome.org/themes/gtk_engines/672"
SRC_URI="http://art.gnome.org/download/themes/gtk_engines/672/${MY_PN}_${PV}-2.tar.gz"
LICENSE="GPL-2"
SLOT="1"

KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Only install the gtk1 engine
	epatch ${FILESDIR}/${P}-gtk1_only.patch

	# Hack so it can find the required files
	cp gtk-common/* gtk1-engine

	eautoreconf
}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ChangeLog README
}
