# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-3.0.2.ebuild,v 1.1 2007/08/12 10:29:35 drac Exp $

inherit autotools eutils

MY_P=${P}-testing

DESCRIPTION="Application for tagging and renaming audio files."
HOMEPAGE="http://cantus.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12.11
	>=dev-cpp/gtkmm-2.10
	>=dev-cpp/libglademm-2.6.3
	>=dev-libs/libsigc++-2.0.17
	media-libs/libvorbis
	media-libs/libogg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-segfault.patch
	eautoconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	newicon dist/pixmaps/${PN}_tag.png ${PN}.png
	make_desktop_entry ${PN} Cantus ${PN}.png
}
