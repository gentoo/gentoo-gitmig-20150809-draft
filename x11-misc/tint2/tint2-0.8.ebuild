# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.8.ebuild,v 1.1 2009/12/20 22:36:45 idl0r Exp $

EAPI="2"

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
SRC_URI="http://tint2.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="battery examples"

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2[X]"
# autoconf >= 2.61 for --docdir, bug 296890
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xineramaproto
	>=sys-devel/autoconf-2.61"

src_configure() {
	econf --docdir=/usr/share/doc/${PF} \
		$(use_enable battery) \
		$(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
