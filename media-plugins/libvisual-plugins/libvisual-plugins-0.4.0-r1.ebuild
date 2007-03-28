# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-plugins/libvisual-plugins-0.4.0-r1.ebuild,v 1.4 2007/03/28 20:03:14 opfer Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Visualization plugins for use with the libvisual framework."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz
	mirror://gentoo/${P}-patches-2.tar.bz2"
LICENSE="GPL-2"

SLOT="0.4"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="alsa debug esd gtk gstreamer jack mplayer opengl"

RDEPEND="~media-libs/libvisual-${PV}
	opengl? ( virtual/opengl )
	esd? ( media-sound/esound )
	jack? ( >=media-sound/jack-audio-connection-kit-0.98 )
	gtk? ( >=x11-libs/gtk+-2 )
	gstreamer? ( >=media-libs/gstreamer-0.8 )
	alsa? ( media-libs/alsa-lib )
	media-libs/fontconfig
	|| ( (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXrender
		) <virtual/x11-7 )"

DEPEND="${RDEPEND}
	|| ( x11-libs/libXt <virtual/x11-7 )
	>=dev-util/pkgconfig-0.14"

src_unpack() {
	unpack ${A}

	epatch "${WORKDIR}/${P}-cxxflags.patch"

	sed -i -e "s:@MKINSTALLDIRS@:${S}/mkinstalldirs:" "${S}"/po/Makefile.*

	cd "${S}"
	epatch "${WORKDIR}/${P}-LIBADD.patch"
	epatch "${WORKDIR}/${P}-64bit.patch"
	epatch "${WORKDIR}/${P}-analyzer.patch"
	epatch "${WORKDIR}/${P}-gforce.patch"
	epatch "${WORKDIR}/${P}-automagic.patch"
	epatch "${WORKDIR}/${P}-gstreamer.patch"
	eautoreconf
}

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug inputdebug) \
		$(use_enable gtk gdkpixbuf-plugin) \
		$(use_enable gstreamer gstreamer-plugin) \
		$(use_enable alsa) \
		$(use_enable opengl gltest) \
		$(use_enable opengl nastyfft) \
		$(use_enable opengl madspin) \
		$(use_enable opengl flower) \
		$(use_enable mplayer) \
		$(use_enable esd) \
		$(use_enable jack) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
