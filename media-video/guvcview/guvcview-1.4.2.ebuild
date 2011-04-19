# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.4.2.ebuild,v 1.3 2011/04/19 09:05:34 tomka Exp $

EAPI=2
MY_P=${PN}-src-${PV}

DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.berlios.de"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pulseaudio"

RDEPEND=">=x11-libs/gtk+-2.14:2
	>=dev-libs/glib-2.10:2
	>=media-video/ffmpeg-0.5
	>=media-libs/libsdl-1.2.10
	>=media-libs/portaudio-19_pre
	>=media-libs/libpng-1.4
	media-libs/libv4l
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-debian-menu \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	rm -rf "${D}"/usr/share/doc/${PN}
}
