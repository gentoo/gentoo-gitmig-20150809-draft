# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xdtv/xdtv-2.2.0.ebuild,v 1.3 2005/07/10 11:48:00 flameeyes Exp $

inherit font multilib flag-o-matic

IUSE="alsa jpeg encode ffmpeg xvid lirc xinerama divx4linux
	neXt Xaw3d mmx zvbi aqua_theme xv debug dvb"
# For use.local.desc:
# media-tv/xdtv:aqua_theme - Adds the Aqua pixmaps theme for the GUI
# media-tv/xdtv:zvbi - Enable VBI Decoding Library for Scanning channels with the xdtv_scantv program

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"

I18N_EN="libxdtv-i18n-en-1.1.0"
I18N_FR="libxdtv-i18n-fr-1.1.0"
I18N_CA="libxdtv-i18n-ca-1.1.0"
I18N_ES="libxdtv-i18n-es-1.1.0"
I18N_DE="libxdtv-i18n-de-1.1.0"
I18N_JA="libxdtv-i18n-ja-1.1.0"
I18N_IT="libxdtv-i18n-it-1.1.0"
THEME_AQUA_EN="libxdtv-theme-aqua-en-1.1.0"
THEME_AQUA_FR="libxdtv-theme-aqua-fr-1.1.0"
THEME_AQUA_CA="libxdtv-theme-aqua-ca-1.1.0"
THEME_AQUA_ES="libxdtv-theme-aqua-es-1.1.0"
THEME_AQUA_DE="libxdtv-theme-aqua-de-1.1.0"
THEME_AQUA_JA="libxdtv-theme-aqua-ja-1.1.0"
THEME_AQUA_IT="libxdtv-theme-aqua-it-1.1.0"

DOWNLOADS_URL="mirror://sourceforge/xawdecode"
SRC_URI="${DOWNLOADS_URL}/${P}.tar.gz
	${DOWNLOADS_URL}/gcc4.patch.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${P}-amd64.patch

	linguas_ca? (
		${DOWNLOADS_URL}/${I18N_CA}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_CA}.tar.gz ) )
	linguas_en? (
		${DOWNLOADS_URL}/${I18N_EN}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_EN}.tar.gz ) )
	linguas_es? (
		${DOWNLOADS_URL}/${I18N_ES}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_ES}.tar.gz ) )
	linguas_fr? (
		${DOWNLOADS_URL}/${I18N_FR}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_FR}.tar.gz ) )
	linguas_de? (
		${DOWNLOADS_URL}/${I18N_DE}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_DE}.tar.gz ) )
	linguas_ja? (
		${DOWNLOADS_URL}/${I18N_JA}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_JA}.tar.gz ) )
	linguas_it? (
		${DOWNLOADS_URL}/${I18N_IT}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_IT}.tar.gz ) )
	!linguas_ca? ( !linguas_es? ( !linguas_fr? ( !linguas_de? ( !linguas_ja? ( !linguas_it? (
		${DOWNLOADS_URL}/${I18N_EN}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_EN}.tar.gz ) ) ) ) ) ) )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/x11
	zvbi? ( >=media-libs/zvbi-0.2.4 )
	neXt? ( x11-libs/neXtaw )
	Xaw3d? ( !neXt? ( x11-libs/Xaw3d ) )
	divx4linux? ( >=media-libs/divx4linux-20030428 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
	xvid? ( =media-libs/xvid-1* )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( media-libs/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( >=media-libs/alsa-lib-0.9 )"

DEPEND="${RDEPEND}
	dvb? ( =media-tv/linuxtv-dvb-headers-3* )"

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
	cd ${WORKDIR}/${1}
	sed -i -e 's:CFLAGS=.*:\0 -fPIC:' src/Makefile.in

	econf || die "econf failed"
	emake || die "emake failed"
}

extension_install() {
	einfo "Installing ${1}"
	cd ${WORKDIR}/${1} \
		&& make DESTDIR=${D} LIBDIR="/usr/$(get_libdir)/${PN}" install
}

src_unpack() {
	unpack ${A}
	# Disable font installation
	sed -i -e '/^install:/,/^$/s:^\t:#:p' ${S}/font/Makefile.in
	# Disable /usr/share/xdtv/icons/* installation
	sed -i -e '/^install-data-local:/,${\:share/xdtv/icons:d}' ${S}/Makefile.in

	cd ${S}
	epatch ${WORKDIR}/gcc4.patch
	epatch ${DISTDIR}/${P}-amd64.patch

	autoreconf || die "autoreconf failed"
	libtoolize --copy --force || die "libtoolize failed"
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

	# linux-dvb headers are installed in /usr/include/dvb to avoid collision-protect
	use dvb && append-flags -I/usr/include/dvb

	econf ${xawconf} \
		$(use_enable divx4linux) \
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
		$(use_enable dvb) \
		--enable-pixmaps \
		--disable-cpu-detection \
		${myconf} \
		|| die "Configuration failed."

	emake OPT="${CFLAGS}" PERF_FLAGS="${CFLAGS}" || die "Compilation failed."

	# Build the extensions (i18n and theme libraries)
	extension_iter extension_compile
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed."

	# .desktop file and default icon
	domenu gentoo/xdtv.desktop
	insinto /usr/share/icons
	doins ${S}/src/xdtv.xpm

	# Install the icons in the hicolor theme
	for dim in 48 32 16; do
		insinto /usr/share/icons/hicolor/${dim}x${dim}/apps
		newins ${S}/xdtv-${dim}.png xdtv.png
	done

	# Install the led-fixed font with font.eclass
	gzip font/led-fixed.pcf
	font_src_install

	# Install documentation
	dodoc ChangeLog AUTHORS INSTALL FAQ* README.* TODO lisez-moi* \
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
