# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xdtv/xdtv-2.3.3.ebuild,v 1.5 2006/10/21 19:17:29 aballier Exp $

inherit font multilib autotools flag-o-matic

IUSE="alsa jpeg encode ffmpeg xvid lirc xinerama neXt Xaw3d mmx zvbi aqua_theme
carbone_theme xv debug x264 ogg png aac nls"
# dvb support disabled, it might not work with external ffmpeg

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"

I18N_PV="1.3.0"
THEMES_PV="1.3.0"

SRC_URI="mirror://sourceforge/xawdecode/${P}.tar.gz"

for lang in ca de en es fr gl it ja pl ru; do
	SRC_URI="${SRC_URI}
		linguas_${lang}? (
			mirror://sourceforge/xawdecode/libxdtv-i18n-${lang}-${I18N_PV}.tar.gz
			aqua_theme? ( mirror://sourceforge/xawdecode/libxdtv-theme-aqua-${lang}-${THEMES_PV}.tar.gz )
			carbone_theme? ( mirror://sourceforge/xawdecode/libxdtv-theme-carbone-${lang}-${THEMES_PV}.tar.gz )
		)"
	IUSE="${IUSE} linguas_${lang}"
done

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="zvbi? ( >=media-libs/zvbi-0.2.4 )
	neXt? ( x11-libs/neXtaw )
	Xaw3d? ( !neXt? ( x11-libs/Xaw3d ) )
	!neXt? ( !Xaw3d? ( || ( x11-libs/libXaw <virtual/x11-7 ) ) )
	xvid? ( >=media-libs/xvid-1.1 )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( media-libs/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	ogg? ( media-libs/libogg
		>=media-libs/libtheora-1.0_alpha5
		media-libs/libvorbis )
	png? ( media-libs/libpng )
	aac? ( media-libs/faac )
	nls? ( virtual/libintl )
	|| ( ( x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXpm
			x11-libs/libXt
			x11-libs/libXmu
			x11-libs/libXxf86vm
			x11-libs/libXxf86dga
			x11-libs/libXv
			x11-apps/xset
			xinerama? ( x11-libs/libXinerama )
		) <virtual/x11-7 )"

#	dvb? ( media-tv/linuxtv-dvb-headers )
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	|| ( ( x11-proto/videoproto
			x11-apps/bdftopcf
			x11-apps/mkfontdir
			x11-apps/mkfontscale
			xinerama? ( x11-proto/xineramaproto )
		) <virtual/x11-7 )"

FONT_S="${S}/font"
FONT_SUFFIX="pcf.gz"

extension_iter() {
	local my_a
	for my_a in ${A} ; do
		my_a=${my_a%%.tar.gz}
		if [ -z ${my_a/libxdtv*/} ] ; then
			eval ${1} ${my_a} || die "${1}(${my_a}) failed."
		fi
	done
}

extension_compile() {
	einfo "Building ${1}"
	cd "${WORKDIR}/${1}"

	epatch "${FILESDIR}/libxdtv-i18n-all-1.3.0-ldflags.patch"

	econf || die "econf failed"
	emake || die "emake failed"
}

extension_install() {
	einfo "Installing ${1}"
	cd ${WORKDIR}/${1} \
		&& emake DESTDIR=${D} LIBDIR="/usr/$(get_libdir)/${PN}" install
}

src_unpack() {
	unpack ${A}
	# Disable font installation
	sed -i -e '/^install:/,/^$/s:^\t:#:p' "${S}/font/Makefile.am"
	# Disable /usr/share/xdtv/icons/* installation
	sed -i -e '/^install-data-local:/,${\:share/xdtv/icons:d}' ${S}/Makefile.am

	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.3.0-setXid.patch"
	epatch "${FILESDIR}/${PN}-2.3.2-parallel-install.patch"
	epatch "${FILESDIR}/${P}-external-ffmpeg.patch"

	# ffmpeg doesn'g use libtool, so the condition for PIC code
	# is __PIC__, not PIC.
	sed -i -e 's/#\(\(.*def *\)\|\(.*defined *\)\|\(.*defined(*\)\)PIC/#\1__PIC__/' \
		libavcodec/i386/dsputil_mmx{.c,_rnd.h,_avg.h} \
		libavcodec/msmpeg4.c \
		|| die "sed failed (__PIC__)"

	eautoreconf
}

src_compile() {
	# Makes the xaw widgets choice deterministic
	local xawconf="--disable-xaw95 --disable-xawm"
	if use neXt ; then
		use Xaw3d && ewarn "Both \"neXt\" and \"Xaw3d\" found in USE. Will use neXtaw widgets."
		xawconf="${xawconf} --enable-nextaw --disable-xaw3d"
	elif use Xaw3d ; then
		xawconf="${xawconf} --disable-nextaw --enable-xaw3d"
	else
		xawconf="${xawconf} --disable-nextaw --disable-xaw3d"
		ewarn "If you want a better GUI toolkit, enable either \"neXt\" or \"Xaw3d\" USE flags."
	fi

	( use mmx || use amd64 ) && myconf="${myconf} --enable-mmx" || \
		myconf="${myconf} --disable-mmx"

	has_version '<x11-base/xorg-x11-7.0' && \
		appdefaultsdir="/etc/X11/app-defaults" || \
		appdefaultsdir="/usr/share/X11/app-defaults"

	econf ${xawconf} \
		$(use_enable alsa) \
		$(use_enable jpeg) \
		$(use_enable lirc) \
		$(use_enable ffmpeg) \
		$(use_enable xvid) \
		$(use_enable xinerama) \
		$(use_enable zvbi) \
		$(use_enable xv xvideo) \
		$(use_enable encode lame) \
		$(use_enable !debug nodebug) \
		--disable-dvb \
		--with-external-ffmpeg \
		$(use_enable ogg) \
		$(use_enable png) \
		$(use_enable aac faac) \
		$(use_enable nls) \
		$(use_enable x264) \
		--enable-pixmaps \
		--disable-cpu-detection \
		--disable-divx4linux \
		--with-appdefaultsdir=${appdefaultsdir} \
		${myconf} \
		|| die "Configuration failed."

	emake BINDNOW_FLAGS="$(bindnow-flags)" OPT="${CFLAGS}" PERF_FLAGS="${CFLAGS}" || die "Compilation failed."

	# Build the extensions (i18n and theme libraries)
	extension_iter extension_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed."

	# .desktop file and default icon
	domenu gentoo/xdtv.desktop
	doicon "${S}/src/xdtv.xpm"

	# Install the icons in the hicolor theme
	for dim in 48 32 16; do
		insinto /usr/share/icons/hicolor/${dim}x${dim}/apps
		newins "${S}/xdtv-${dim}.png" xdtv.png
	done

	# Remove fonts from being installed by autotools
	rm -rf "${D}/usr/$(get_libdir)/X11"

	# Install the led-fixed font with font.eclass
	gzip font/*.pcf
	font_src_install

	# Install documentation
	dodoc ChangeLog AUTHORS FAQ* README.* TODO lisez-moi* \
		xdtvrc.sample lircrc.*.sample
	docinto alevt
	dodoc alevt/README alevt/ReadmeGR alevt/CHANGELOG alevt/COPYRIGHT

	# Install the extensions (i18n and theme libraries)
	extension_iter extension_install
}

pkg_postinst() {
	echo
	einfo "Please note that this ebuild created a suid-binary:"
	einfo "/usr/bin/xdtv_v4l-conf"
	echo
	einfo "The OSD font has moved. You probably should add"
	einfo "this path to your X configuration:"
	einfo "/usr/share/fonts/${PN}"
	echo
}
