# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkdatabox/gtkdatabox-0.9.1.1.ebuild,v 1.2 2009/06/27 09:03:44 scarabeus Exp $

EAPI="2"

DESCRIPTION="Gtk+ Widgets for live display of large amounts of fluctuating numerical data"
HOMEPAGE="http://sourceforge.net/projects/gtkdatabox/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples +glade test"

RDEPEND="x11-libs/gtk+:2
	glade? (
		dev-util/glade:3
		gnome-base/libglade
	)
"

DEPEND=${RDEPEND}

src_configure() {
	econf \
		--enable-libtool-lock \
		--disable-dependency-tracking \
		$(use_enable glade libglade) \
		$(use_enable glade) \
		$(use_enable doc gtk-doc) \
		$(use_enable test gtktest)
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation Failed"

	dodoc AUTHORS ChangeLog README TODO || "dodoc failed"

	if use examples; then
		emake clean -C examples || die "Cleaning examples failed"
		docinto examples
		dodoc "${S}/examples/*" || die "Copy examples to doc failed."
	fi
}
