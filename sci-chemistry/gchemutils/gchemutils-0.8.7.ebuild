# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gchemutils/gchemutils-0.8.7.ebuild,v 1.2 2008/04/21 01:51:55 je_fro Exp $

inherit gnome2 autotools

MY_P="gnome-chemistry-utils-${PV}"
DESCRIPTION="C++ classes and Gtk+-2 widgets related to chemistry"
HOMEPAGE="http://www.nongnu.org/gchemutils/"
SRC_URI="http://savannah.nongnu.org/download/gchemutils/0.8/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=gnome-base/libglade-2*
		>=gnome-base/libgnomeprintui-2.4.0
		=x11-libs/goffice-0.4*
		x11-libs/gtkglext
		>=sci-chemistry/openbabel-2.1.1
		sci-chemistry/bodr
		sci-chemistry/chemical-mime-data"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	gnome2_src_unpack
	eautoreconf
}

src_compile() {
	gnome2_src_compile --disable-update-databases --docdir=/usr/share/doc/${PN}/html
}

pkg_postinst() {
	elog "You can safely ignore any 'Unknown media type in type blah' warnings above."
	elog "For more info see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420795 "
}
