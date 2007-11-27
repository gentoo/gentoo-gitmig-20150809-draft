# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xdtv/xdtv-2.2.0-r1.ebuild,v 1.17 2007/11/27 10:14:40 zzam Exp $

WANT_AUTOMAKE="1.7"
WANT_AUTOCONF="2.5"

inherit font multilib autotools eutils

IUSE="alsa jpeg encode ffmpeg xvid lirc xinerama neXt Xaw3d mmx zvbi aqua_theme carbone_theme xv debug dvb"

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"

I18N_PV="1.2.0"
THEMES_PV="1.2.0"

I18N_EN="libxdtv-i18n-en-${I18N_PV}"
I18N_FR="libxdtv-i18n-fr-${I18N_PV}"
I18N_CA="libxdtv-i18n-ca-${I18N_PV}"
I18N_ES="libxdtv-i18n-es-${I18N_PV}"
I18N_DE="libxdtv-i18n-de-${I18N_PV}"
I18N_JA="libxdtv-i18n-ja-${I18N_PV}"
I18N_IT="libxdtv-i18n-it-${I18N_PV}"
THEME_AQUA_EN="libxdtv-theme-aqua-en-${THEMES_PV}"
THEME_AQUA_FR="libxdtv-theme-aqua-fr-${THEMES_PV}"
THEME_AQUA_CA="libxdtv-theme-aqua-ca-${THEMES_PV}"
THEME_AQUA_ES="libxdtv-theme-aqua-es-${THEMES_PV}"
THEME_AQUA_DE="libxdtv-theme-aqua-de-${THEMES_PV}"
THEME_AQUA_JA="libxdtv-theme-aqua-ja-${THEMES_PV}"
THEME_AQUA_IT="libxdtv-theme-aqua-it-${THEMES_PV}"
THEME_CARBONE_EN="libxdtv-theme-carbone-en-${THEMES_PV}"
THEME_CARBONE_FR="libxdtv-theme-carbone-fr-${THEMES_PV}"
THEME_CARBONE_CA="libxdtv-theme-carbone-ca-${THEMES_PV}"
THEME_CARBONE_ES="libxdtv-theme-carbone-es-${THEMES_PV}"
THEME_CARBONE_DE="libxdtv-theme-carbone-de-${THEMES_PV}"
THEME_CARBONE_JA="libxdtv-theme-carbone-ja-${THEMES_PV}"
THEME_CARBONE_IT="libxdtv-theme-carbone-it-${THEMES_PV}"

DOWNLOADS_URL="mirror://sourceforge/xawdecode"
SRC_URI="${DOWNLOADS_URL}/${P}.tar.gz
	${DOWNLOADS_URL}/${P}-gcc4-amd64.patch.tar.gz

	linguas_ca? (
		${DOWNLOADS_URL}/${I18N_CA}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_CA}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_CA}.tar.gz ) )
	linguas_en? (
		${DOWNLOADS_URL}/${I18N_EN}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_EN}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_EN}.tar.gz ) )
	linguas_es? (
		${DOWNLOADS_URL}/${I18N_ES}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_ES}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_ES}.tar.gz ) )
	linguas_fr? (
		${DOWNLOADS_URL}/${I18N_FR}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_FR}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_FR}.tar.gz ) )
	linguas_de? (
		${DOWNLOADS_URL}/${I18N_DE}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_DE}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_DE}.tar.gz ) )
	linguas_ja? (
		${DOWNLOADS_URL}/${I18N_JA}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_JA}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_JA}.tar.gz ) )
	linguas_it? (
		${DOWNLOADS_URL}/${I18N_IT}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_IT}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_IT}.tar.gz ) )
	!linguas_ca? ( !linguas_es? ( !linguas_fr? ( !linguas_de? ( !linguas_ja? ( !linguas_it? (
		${DOWNLOADS_URL}/${I18N_EN}.tar.gz
		aqua_theme? ( ${DOWNLOADS_URL}/${THEME_AQUA_EN}.tar.gz )
		carbone_theme? ( ${DOWNLOADS_URL}/${THEME_CARBONE_EN}.tar.gz ) ) ) ) ) ) )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND="zvbi? ( >=media-libs/zvbi-0.2.4 )
	neXt? ( x11-libs/neXtaw )
	Xaw3d? ( !neXt? ( x11-libs/Xaw3d ) )
	ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
	xvid? ( =media-libs/xvid-1* )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( media-libs/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXt
	x11-libs/libICE
	x11-libs/libXmu
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga
	x11-libs/libSM
	x11-libs/libXaw
	x11-libs/libXv
	"

DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )
	x11-proto/videoproto"

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

	econf || die "econf failed"
	emake || die "emake failed"
}

extension_install() {
	einfo "Installing ${1}"
	cd "${WORKDIR}/${1}" \
		&& make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/${PN}" install
}

src_unpack() {
	unpack ${A}
	# Disable font installation
	sed -i -e '/^install:/,/^$/s:^\t:#:p' "${S}"/font/Makefile.in
	# Disable /usr/share/xdtv/icons/* installation
	sed -i -e '/^install-data-local:/,${\:share/xdtv/icons:d}' "${S}"/Makefile.in

	cd "${S}"
	epatch "${WORKDIR}/${P}-gcc4-amd64.patch"

	has_version '<x11-base/xorg-x11-7.0' && \
		appdefaultsdir="/etc/X11/app-defaults" || \
		appdefaultsdir="/usr/share/X11/app-defaults"

	sed -i -e 's:^app_defaults=""$:app_defaults="'${appdefaultsdir}'":' "${S}/configure.in"

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
	make DESTDIR="${D}" install || die "Installation failed."

	# .desktop file and default icon
	domenu gentoo/xdtv.desktop
	insinto /usr/share/icons
	doins "${S}"/src/xdtv.xpm

	# Install the icons in the hicolor theme
	for dim in 48 32 16; do
		insinto /usr/share/icons/hicolor/${dim}x${dim}/apps
		newins "${S}"/xdtv-${dim}.png xdtv.png
	done

	# Install the led-fixed font with font.eclass
	gzip font/led-fixed.pcf
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
	elog "Please note that this ebuild created a suid-binary:"
	elog "/usr/bin/xdtv_v4l-conf"
	echo
	elog "The OSD font has moved. You probably should add"
	elog "this path to your X configuration:"
	elog "/usr/share/fonts/${PN}"
	echo
}
