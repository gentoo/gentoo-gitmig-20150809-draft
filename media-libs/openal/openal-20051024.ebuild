# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-20051024.ebuild,v 1.7 2006/02/14 15:50:01 agriffis Exp $

inherit eutils gnuconfig

IUSE="alsa arts esd sdl debug vorbis mpeg"
DESCRIPTION="OpenAL, the Open Audio Library, is an open, vendor-neutral, cross-platform API for interactive, primarily spatialized audio"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/openal/${P}.tar.bz2"
HOMEPAGE="http://www.openal.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0.2 )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	vorbis? ( media-libs/libvorbis )
	mpeg? ( media-libs/smpeg )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

S="${S}/linux"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	use alsa && epatch ${FILESDIR}/${P}-alsa_dmix.patch
	epatch ${FILESDIR}/${P}-amd64-configure.patch

	gnuconfig_update

	export WANT_AUTOCONF=2.5
	autoheader || die
	autoconf || die
}

src_compile() {
	econf \
		--enable-paranoid-locks \
		--libdir=/usr/$(get_libdir) \
		--enable-capture \
		--enable-optimization \
		$(use_enable esd) \
		$(use_enable sdl) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable mpeg smpeg) \
		$(use_enable vorbis) \
		$(use_enable debug debug-maximus) || die
	emake all || die
}

src_test() {
	einfo "Testing is broken, so we're going to skip it."
}

src_install() {
	cd ${S}/linux

	make install DESTDIR="${D}" || die

	dodoc ChangeLog INSTALL NOTES PLATFORM TODO
	dodoc ${FILESDIR}/openalrc
	makeinfo doc/openal.texi
	doinfo doc/openal.info

	cd ${S}
	dohtml docs/*.html
}

pkg_postinst() {
	einfo "There is a sample openalrc file in /usr/share/doc/${P} which"
	einfo "sets up 4 speaker surround sound with ALSA.  Simply copy it to your:"
	einfo " ~/.openalrc"
	einfo "to use it."
}
