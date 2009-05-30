# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.1.0.ebuild,v 1.4 2009/05/30 11:54:53 ssuominen Exp $

EAPI=2
inherit autotools eutils

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
	>=media-video/ffmpeg-0.4.9_p20090201
	>=media-libs/libsdl-1.2.10
	>=media-libs/portaudio-19_pre
	media-libs/libpng
	media-sound/twolame
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.5-implicit_declaration_setlocale.patch \
		"${FILESDIR}"/${P}-automagic_pulseaudio.patch
	eautoreconf
}

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
