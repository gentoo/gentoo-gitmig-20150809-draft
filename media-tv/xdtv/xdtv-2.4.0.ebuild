# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xdtv/xdtv-2.4.0.ebuild,v 1.12 2011/05/15 15:26:01 scarabeus Exp $

inherit eutils multilib flag-o-matic toolchain-funcs autotools

IUSE="alsa jpeg encode ffmpeg xvid lirc xinerama neXt Xaw3d mmx zvbi aqua_theme
carbone_theme xv debug ogg png nls schedule"

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"

I18N_PV="${PV}"
THEMES_PV="${PV}"

SRC_URI="mirror://sourceforge/xawdecode/${P}.tar.gz"

for lang in ca cs de en es fr gl it pl ru sv; do
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
KEYWORDS="~amd64 ~ppc x86"

COMMON_DEPEND="zvbi? ( >=media-libs/zvbi-0.2.4 )
	neXt? ( x11-libs/neXtaw )
	Xaw3d? ( !neXt? ( x11-libs/Xaw3d ) )
	!neXt? ( !Xaw3d? ( x11-libs/libXaw ) )
	xvid? ( >=media-libs/xvid-1.1 )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( virtual/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	ogg? ( media-libs/libogg
		>=media-libs/libtheora-1.0_alpha5
		media-libs/libvorbis )
	png? ( media-libs/libpng )
	nls? ( virtual/libintl )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga
	x11-libs/libXv
	x11-apps/xset
	xinerama? ( x11-libs/libXinerama )
	ffmpeg? ( virtual/ffmpeg )"

DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )
	x11-proto/videoproto
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-apps/bdftopcf
	x11-apps/mkfontdir
	x11-apps/mkfontscale
	xinerama? ( x11-proto/xineramaproto )"

RDEPEND="${COMMON_DEPEND}
	schedule? ( sys-process/at )"

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
	pushd "${WORKDIR}/${1}" > /dev/null

	econf
	emake CC=$(tc-getCC) || die
	popd > /dev/null
}

extension_install() {
	einfo "Installing ${1}"
	pushd "${WORKDIR}/${1}" > /dev/null
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/${PN}" install || die
	popd > /dev/null
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	einfo "Cleaning up included ffmpeg to not interfere with headers inclusion"
	rm -rf libav* libswscale libpostproc

	epatch "${FILESDIR}/${P}-ffmpeg.patch"
	epatch "${FILESDIR}/${P}-ffmpegheaders.patch"
	epatch "${FILESDIR}/${P}-lavc.patch"

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

	econf ${xawconf} \
		$(use_enable mmx) \
		$(use_enable alsa) \
		$(use_enable jpeg) \
		$(use_enable lirc) \
		$(use_enable ffmpeg) \
		$(use_with ffmpeg external-ffmpeg) \
		$(use_enable xvid) \
		$(use_enable xinerama) \
		$(use_enable zvbi) \
		$(use_enable xv xvideo) \
		$(use_enable encode lame) \
		$(use_enable !debug nodebug) \
		--disable-dvb \
		$(use_enable ogg) \
		$(use_enable png) \
		$(use_enable nls) \
		--with-fontdir="/usr/share/fonts/${PN}" \
		--enable-makefonts \
		--enable-pixmaps \
		--disable-cpu-detection \
		--disable-divx4linux \
		--with-appdefaultsdir=${appdefaultsdir}

	emake || die "Compilation failed."

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
		newins "${S}/xdtv-${dim}.png" xdtv.png || die
	done

	# Install documentation
	dodoc ChangeLog AUTHORS FAQ* README.* TODO lisez-moi* \
		xdtvrc.sample lircrc.*.sample
	docinto alevt
	dodoc alevt/README alevt/ReadmeGR alevt/CHANGELOG alevt/COPYRIGHT

	use schedule || rm "${D}/usr/bin/xdtv_record.sh"

	# Install the extensions (i18n and theme libraries)
	extension_iter extension_install
}

pkg_postinst() {
	elog ""
	elog "Please note that this ebuild created a suid-binary:"
	elog "/usr/bin/xdtv_v4l-conf"
	elog ""
	elog "The OSD font has moved. You probably should add"
	elog "this path to your X configuration:"
	elog "/usr/share/fonts/${PN}"
	elog ""

	if use schedule; then
		elog ""
		elog "You need to have atd running to use xdtv_recond.sh"
		elog "type : '/etc/init.d/atd start' as root"
		elog ""
	fi
}
