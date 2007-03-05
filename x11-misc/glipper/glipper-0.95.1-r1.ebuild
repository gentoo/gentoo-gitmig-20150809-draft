# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-0.95.1-r1.ebuild,v 1.1 2007/03/05 22:01:57 swegener Exp $

WANT_AUTOCONF="2.6"
WANT_AUTOMAKE="1.9"

inherit autotools

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=gnome-base/libglade-2.0.0
	gnome? ( >=gnome-base/libgnome-2.0.0 )"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.23
	>=dev-util/pkgconfig-0.9.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable gnome) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
