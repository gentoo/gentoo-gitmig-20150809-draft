# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.7_beta2.ebuild,v 1.1 2009/06/07 18:15:26 idl0r Exp $

EAPI="2"

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
SRC_URI="http://tint2.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable doc) \
		$(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
