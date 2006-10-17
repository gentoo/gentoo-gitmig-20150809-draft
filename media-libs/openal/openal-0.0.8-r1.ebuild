# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-0.0.8-r1.ebuild,v 1.4 2006/10/17 14:55:18 drizzt Exp $

inherit eutils

DESCRIPTION="OpenAL, the Open Audio Library, is an open, vendor-neutral, cross-platform API for interactive, primarily spatialized audio"
HOMEPAGE="http://www.openal.org"
SRC_URI="http://www.openal.org/openal_webstf/downloads/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa arts debug esd mp3 sdl vorbis"

RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0.2 )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	vorbis? ( media-libs/libvorbis )
	mp3? ( media-libs/libmad )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch"
	epatch ${FILESDIR}/${PV} || die

	sed -i \
		-e "/^Requires:/d" \
		admin/pkgconfig/openal.pc.in || die "sed openal.pc.in failed"
}

src_compile() {
	export WANT_AUTOCONF=2.5
	autoconf \
		|| die "autoconf failed"

	econf \
		--libdir=/usr/$(get_libdir) \
		$(use_enable esd) \
		$(use_enable sdl) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable mp3) \
		$(use_enable vorbis) \
		$(use_enable debug debug-maximus) \
		|| die "econf failed"

	emake -j1 all \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog NEWS NOTES README TODO
}
