# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/adplay/adplay-1.7.ebuild,v 1.2 2011/12/22 22:01:30 maekke Exp $

DESCRIPTION="A console player for AdLib music"
HOMEPAGE="http://adplug.sourceforge.net"
SRC_URI="mirror://sourceforge/adplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="alsa ao esd oss sdl"

RDEPEND="media-libs/adplug
	dev-cpp/libbinio
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable alsa output-alsa) \
		$(use_enable ao output-ao) \
		$(use_enable esd output-esound) \
		$(use_enable oss output-oss) \
		$(use_enable sdl output-sdl)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
