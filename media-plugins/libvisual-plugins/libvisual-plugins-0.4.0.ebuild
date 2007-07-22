# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-plugins/libvisual-plugins-0.4.0.ebuild,v 1.14 2007/07/22 09:22:09 dberkholz Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Visualization plugins for use with the libvisual framework."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0.4"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug esd gtk jack opengl"

RDEPEND="~media-libs/libvisual-${PV}
	opengl? ( virtual/opengl )
	esd? ( media-sound/esound )
	jack? ( >=media-sound/jack-audio-connection-kit-0.98 )
	gtk? ( >=x11-libs/gtk+-2 )
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender"

DEPEND="${RDEPEND}
	x11-libs/libXt
	>=dev-util/pkgconfig-0.14"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-cxxflags.patch"

	sed -i -e "s:@MKINSTALLDIRS@:${S}/mkinstalldirs:" "${S}"/po/Makefile.*

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
