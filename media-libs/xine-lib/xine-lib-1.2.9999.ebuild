# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1.2.9999.ebuild,v 1.1 2011/10/15 21:59:42 idl0r Exp $

EAPI=4

inherit eutils flag-o-matic toolchain-funcs autotools multilib mercurial

: ${EHG_REPO_URI:=http://hg.debian.org/hg/xine-lib/xine-lib-1.2}

DESCRIPTION="Core libraries for Xine movie player"
HOMEPAGE="http://hg.debian.org/hg/xine-lib/xine-lib-1.2/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="1"
KEYWORDS=""

IUSE="a52 aac aalib alsa altivec antialiasing asf directfb dts debug dvb dxr3
esd fbcon flac fontconfig fusion gdk-pixbuf glu gnome imagemagick ipv6 jack
real libcaca libv4l mad mmap mng modplug musepack nls nosefart opengl oss pulseaudio
samba sdl speex static-libs theora truetype v4l v4l2 vcd vdpau vdr vidix vis vorbis
wavpack win32codecs X xcb xinerama xv xvmc"

REQUIRED_USE="fontconfig? ( truetype )
	xv? ( X )
	xinerama? ( X )
	vidix? ( || ( X fbcon ) )"

# xinerama only used for dxr3

RDEPEND="sys-libs/zlib
	dev-libs/libxdg-basedir
	media-video/ffmpeg
	mng? ( media-libs/libmng )
	vcd? ( dev-libs/libcdio[-minimal] media-video/vcdimager )
	speex? ( media-libs/libogg media-libs/speex )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	theora? ( media-libs/libogg >=media-libs/libtheora-1.0_alpha6 )
	aalib? ( media-libs/aalib )
	libcaca? ( >=media-libs/libcaca-0.99_beta1 )
	aac? ( media-libs/faad2 )
	dts? ( media-libs/libdca )
	libv4l? ( media-libs/libv4l )
	flac? ( >=media-libs/flac-1.1.2 )
	a52? ( >=media-libs/a52dec-0.7.4-r5 )
	mad? ( media-libs/libmad )
	imagemagick? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick ) )
	modplug? ( media-libs/libmodplug )
	fontconfig? ( media-libs/fontconfig )
	truetype? ( media-libs/freetype:2 )
	musepack? ( media-sound/musepack-tools )
	alsa? ( media-libs/alsa-lib )
	wavpack? ( >=media-sound/wavpack-4.31 )
	dxr3? ( >=media-libs/libfame-0.9.0 )
	fusion? ( media-libs/FusionSound )
	esd? ( media-sound/esound )
	pulseaudio? ( media-sound/pulseaudio )
	jack? ( >=media-sound/jack-audio-connection-kit-0.100 )
	samba? ( net-fs/samba[smbclient] )
	real? (
		x86? ( media-libs/win32codecs )
		x86-fbsd? ( media-libs/win32codecs )
		amd64? ( media-libs/amd64codecs )
	)
	win32codecs? ( >=media-libs/win32codecs-0.50 )
	vdpau? ( x11-libs/libvdpau )
	sdl? ( >=media-libs/libsdl-1.1.5 )
	xcb? ( >=x11-libs/libxcb-1.0 )
	gdk-pixbuf? ( x11-libs/gdk-pixbuf )
	X? ( x11-libs/libXext
		x11-libs/libX11
		xinerama? ( x11-libs/libXinerama )
		xv? ( x11-libs/libXv )
	)
	xvmc? ( x11-libs/libXvMC )
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	opengl? ( virtual/opengl )
	glu? ( virtual/glu )
"
DEPEND="${RDEPEND}
	fbcon? ( virtual/os-headers )
	sys-devel/gettext
	dev-util/pkgconfig
	nls? ( virtual/libintl )
	v4l? ( virtual/os-headers )
	v4l2? ( virtual/os-headers )
	oss? ( virtual/os-headers )

	X? ( x11-proto/xproto
		x11-proto/xextproto
		xinerama? ( x11-proto/xineramaproto )
		xv? ( x11-proto/videoproto )
	)
"

src_prepare() {
	use vdr && sed -i src/vdr/input_vdr.c -e '/define VDR_ABS_FIFO_DIR/s|".*"|"/var/vdr/xine"|'

	eautopoint
	eautoreconf
}

src_configure() {
	# Disabled for testing, also there are "no" bug references...
	# If that causes trouble again fix it *properly* and send patches to
	# upstream please!

	#prevent quicktime crashing
#	append-flags -frename-registers -ffunction-sections

	# Specific workarounds for too-few-registers arch...
#	if [ "$(tc-arch)" = "x86" ]; then
#		filter-flags -fforce-addr # bug 104189
#		filter-flags -momit-leaf-frame-pointer # break on gcc 3.4/4.x, bug 104189
#		filter-flags -fno-omit-frame-pointer # breaks per bug #149704
#		is-flag -O? || append-flags -O2
#	fi

	# Set the correct win32 dll path, bug #197236
	local win32dir
	if has_multilib_profile ; then
		win32dir=/usr/$(ABI="x86" get_libdir)/win32
	else
		win32dir=/usr/$(get_libdir)/win32
	fi

	# bundled:
	# nosefart, vidix

	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable antialiasing) \
		$(use_enable nls) \
		$(use_enable altivec) \
		$(use_enable mmap) \
		$(use_enable oss) \
		$(use_enable aalib) \
		$(use_enable directfb) \
		$(use_enable dxr3) \
		$(use_enable fbcon fb) \
		$(use_enable opengl) \
		$(use_enable glu) \
		$(use_enable vidix) \
		$(use_enable xinerama) \
		$(use_enable xvmc) \
		$(use_enable vdpau) \
		$(use_enable dvb) \
		$(use_enable gnome gnomevfs) \
		$(use_enable samba) \
		$(use_enable v4l) \
		$(use_enable v4l2) \
		$(use_enable libv4l) \
		$(use_enable vcd) \
		$(use_enable vdr) \
		$(use_enable a52 a52dec) \
		$(use_enable asf) \
		$(use_enable nosefart) \
		$(use_enable aac faad) \
		$(use_enable gdk-pixbuf gdkpixbuf) \
		$(use_enable dts) \
		$(use_enable mad) \
		$(use_enable modplug) \
		$(use_enable musepack) \
		$(use_enable mng) \
		$(use_enable real real-codecs) \
		$(use_enable win32codecs w32dll) \
		$(use_enable vis) \
		$(use_with truetype freetype) \
		$(use_with fontconfig) \
		$(use_with X x) \
		$(use_with alsa) \
		$(use_with esd esound) \
		$(use_with fusion fusionsound) \
		$(use_with jack) \
		$(use_with pulseaudio) \
		$(use_with libcaca caca) \
		$(use_with sdl) \
		$(use_with xcb) \
		$(use_with imagemagick) \
		$(use_with flac libflac) \
		$(use_with speex) \
		$(use_with theora) \
		$(use_with vorbis) \
		$(use_with wavpack) \
		--disable-optimizations \
		--with-xv-path=/usr/$(get_libdir) \
		--with-w32-path=${win32dir} \
		--with-real-codecs-path=/usr/$(get_libdir)/codecs \
		--enable-fast-install \
		--disable-dependency-tracking \
		--htmldir=/usr/share/doc/${PF}/html \
		--docdir=/usr/share/doc/${PF} \
		--with-external-libxdg-basedir
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	# We don't need the License
	rm -f "${D}"/usr/share/doc/${PF}/COPYING

	# Empty files etc.
	rm -rf "${D}"/usr/share/doc/${PF}/html/

	if ! use static-libs; then
		rm -f "${D}"/usr/lib*/*.la
	fi
}
