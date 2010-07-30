# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mangler/mangler-1.2.0.ebuild,v 1.3 2010/07/30 09:28:06 hwoarang Exp $

EAPI=2

DESCRIPTION="Open source VOIP client capable of connecting to Ventrilo 3.x servers"
HOMEPAGE="http://www.mangler.org/"
SRC_URI="http://www.mangler.org/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+alsa celt espeak g15 +gsm pulseaudio +speex +xosd"

RDEPEND="dev-cpp/gtkmm:2.4
	gnome-base/librsvg
	alsa? ( media-libs/alsa-lib )
	celt? ( media-libs/celt )
	espeak? ( app-accessibility/espeak )
	g15? ( app-misc/g15daemon )
	gsm? ( media-sound/gsm )
	>=dev-libs/dbus-glib-0.80
	pulseaudio? ( media-sound/pulseaudio )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/}

src_configure() {
	econf $(use_with alsa) \
	$(use_with pulseaudio) \
	$(use_enable celt) \
	$(use_enable espeak) \
	$(use_enable g15) \
	$(use_enable gsm) \
	$(use_enable speex) \
	$(use_enable xosd)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
