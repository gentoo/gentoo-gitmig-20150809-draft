# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/moonlight/moonlight-1.0.1.ebuild,v 1.4 2010/08/31 15:38:33 ssuominen Exp $

EAPI=2

inherit eutils mono multilib nsplugins

MY_P=moon-${PV}
DESCRIPTION="Moonlight is an open source implementation of Silverlight"
HOMEPAGE="http://www.mono-project.com/Moonlight"
SRC_URI="ftp://ftp.novell.com/pub/mono/sources/moon/${PV}/${MY_P}.tar.bz2"
LICENSE="LGPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa pulseaudio debug test"
RESTRICT="mirror"

# Needed for Moonlight-2.0 profile:
#LICENSE+="Ms-PL"
# +more
#	>=dev-dotnet/rsvg-sharp-2.24.0
#	>=dev-dotnet/gtk-sharp-2.12.7
#	>=dev-lang/mono-2.2-r3[moonlight]
#	>=dev-dotnet/dbus-sharp-0.6.1a

#Moonlight-1.0 is essentially a browser plugin written in pure C.
RDEPEND="
	>=x11-libs/gtk+-2.14
	>=dev-libs/glib-2.18
	>=x11-libs/cairo-1.8.0
	>=media-video/ffmpeg-0.4.9_p20090121
	>=net-libs/xulrunner-1.9.0.5:1.9
	x11-libs/libXrandr
	alsa? ( >=media-libs/alsa-lib-1.0.18 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )
	>=media-libs/freetype-2.3.7
	>=media-gfx/imagemagick-6.2.8
	>=media-libs/fontconfig-2.6.0
	"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i \
		-e "s:TEST_SUBDIR = test::"	\
		-e "s:TOOLS_SUBDIR = tools::"	\
		 Makefile.in

	epatch "${FILESDIR}"/${P}-glibc-212.patch
}

src_configure() {
	econf	--enable-shared \
		--disable-static \
	 	--with-cairo=system \
		--with-ffmpeg=yes \
		--with-ff3=yes \
		--without-ff2 \
		$(use_with alsa) \
		$(use_with pulseaudio) \
		$(use_with debug) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	inst_plugin /usr/$(get_libdir)/moon/plugin/libmoonloader.so || die "installing libmoonloader failed"
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
