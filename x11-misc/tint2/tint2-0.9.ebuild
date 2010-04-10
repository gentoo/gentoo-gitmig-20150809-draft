# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.9.ebuild,v 1.4 2010/04/10 08:43:01 hwoarang Exp $

EAPI="2"

MY_P="${PN}-${PV/_rc/-rc}"

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
SRC_URI="http://tint2.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="battery examples"

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	media-libs/imlib2[X]"
# autoconf >= 2.61 for --docdir, bug 296890
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xineramaproto
	>=sys-devel/autoconf-2.61"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --docdir=/usr/share/doc/${PF} \
		$(use_enable battery) \
		$(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
