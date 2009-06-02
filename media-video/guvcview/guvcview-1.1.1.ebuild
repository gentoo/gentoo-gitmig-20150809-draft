# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.1.1.ebuild,v 1.1 2009/06/02 11:38:13 ssuominen Exp $

EAPI=2
MY_P=${PN}-src-${PV}

DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.berlios.de"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2:2
	>=media-video/ffmpeg-0.5
	>=media-libs/libsdl-1.2.10
	>=media-libs/portaudio-19_pre
	media-libs/libpng
	media-sound/twolame
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"/usr/share/{menu,doc/${PN}}
	dodoc AUTHORS ChangeLog README
}
