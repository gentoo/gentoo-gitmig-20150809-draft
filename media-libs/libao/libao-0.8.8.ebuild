# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.8.ebuild,v 1.4 2008/01/30 02:02:50 cla Exp $

inherit eutils libtool

DESCRIPTION="the audio output library"
HOMEPAGE="http://www.xiph.org/ao"
SRC_URI="http://downloads.xiph.org/releases/ao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="alsa arts esd nas mmap pulseaudio doc"

RDEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-plugins/libao-pulse"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-alsa09-buffertime-milliseconds.patch
	elibtoolize
}

src_compile() {
	econf --enable-shared --enable-static \
		$(use_enable alsa alsa09) \
		$(use_enable mmap alsa09-mmap) \
		$(use_enable arts) \
		$(use_enable esd) \
		$(use_enable nas) \
		$(use_enable pulseaudio pulse)

	emake || die "emake failed."
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."

	rm -rf "${D}"/usr/share/doc/libao*
	dodoc AUTHORS CHANGES README TODO
	use doc && dohtml -A c doc/*.html
}
