# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.30.ebuild,v 1.2 2004/10/19 20:36:27 zypher Exp $

inherit eutils flag-o-matic

DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://download.berlios.de/"${PN}/${P}".tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="alsa altivec arts debug nls oggvorbis truetype xvid"

RDEPEND="virtual/x11
	media-sound/madplay
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93
	>=dev-libs/libxml2-2.6.7
	>=x11-libs/gtk+-2.4.1
	>=media-libs/faac-1.23.5
	>=media-libs/faad2-2.0-r2
	xvid? ( >=media-libs/xvid-1.0.0 )
	x86? ( dev-lang/nasm )
	nls? ( >=sys-devel/gettext-0.12.1 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0.1 )
	arts? ( >=kde-base/arts-1.2.3 )
	truetype? ( >=media-libs/freetype-2.1.5 )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )"
# media-sound/toolame is supported as well

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58
		>=sys-devel/automake-1.8.3"

filter-flags "-fno-default-inline"
filter-flags "-funroll-loops"
filter-flags "-funroll-all-loops"
filter-flags "-fforce-addr"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/avidemux-2.0.30_fixes.patch
	if use amd64 ; then
	    cd ${S}/adm_lavcodec/i386
	    epatch ${FILESDIR}/avidemux-2.0.30_amd64_cpuutil.patch
	fi
}

src_compile() {
	local myconf
	myconf="--with-gnu-ld --disable-warnings"

	# --enable-profile        creates profiling infos default=no
	# --enable-pch            enables precompiled header support
	#                         (currently only KCC) default=no
	# --enable-final          build size optimized apps
	#                         (experimental - needs lots of memory)
	# --disable-closure       don't delay template instantiation

	use debug && myconf="${myconf} --enable-debug=full"
	use nls || myconf="${myconf} --disable-nls"
	use altivec && myconf="${myconf} --enable-altivec"
	econf ${myconf} || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
}

pkg_postinst() {
	if use ppc ; then
		echo
		einfo "OSS sound output may not work on ppc"
		einfo "If your hear only static noise, try"
		einfo "changing the sound device to ALSA or arts"
	fi
}
