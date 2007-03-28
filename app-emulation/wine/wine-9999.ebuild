# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-9999.ebuild,v 1.20 2007/03/28 07:54:51 vapier Exp $

EGIT_REPO_URI="git://source.winehq.org/git/wine.git"

inherit eutils flag-o-matic multilib git

DESCRIPTION="free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.winehq.com/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-*"
IUSE="alsa arts cups dbus esd hal jack jpeg lcms ldap nas ncurses opengl oss scanner xml X"
RESTRICT="test" #72375

RDEPEND=">=media-libs/freetype-2.0.0
	media-fonts/corefonts
	ncurses? ( >=sys-libs/ncurses-5.2 )
	jack? ( media-sound/jack-audio-connection-kit )
	dbus? ( sys-apps/dbus )
	hal? ( sys-apps/hal )
	X? (
		x11-libs/libXrandr
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXxf86vm
		x11-apps/xmessage
	)
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	jpeg? ( media-libs/jpeg )
	ldap? ( net-nds/openldap )
	lcms? ( media-libs/lcms )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	>=media-gfx/fontforge-20060703
	scanner? ( media-gfx/sane-backends )
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-soundlibs-2.1
		>=sys-kernel/linux-headers-2.6
	)"
DEPEND="${RDEPEND}
	X? (
		x11-proto/inputproto
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
	)
	sys-devel/bison
	sys-devel/flex"

S=${WORKDIR}/${EGIT_PROJECT}

src_unpack() {
	git_src_unpack
	cd "${S}"

	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in
	epatch "${FILESDIR}"/wine-gentoo-no-ssp.patch #66002
	sed -i '/^MimeType/d' tools/wine.desktop || die #117785
}

config_cache() {
	local h ans="no"
	use $1 && ans="yes"
	shift
	for h in "$@" ; do
		[[ ${h} == *.h ]] \
			&& h=header_${h} \
			|| h=lib_${h}
		export ac_cv_${h//[:\/.]/_}=${ans}
	done
}

src_compile() {
	export LDCONFIG=/bin/true
	use arts    || export ac_cv_path_ARTSCCONFIG=""
	use esd     || export ac_cv_path_ESDCONFIG=""
	use scanner || export ac_cv_path_sane_devel="no"
	config_cache jack jack/jack.h
	config_cache cups cups/cups.h
	config_cache alsa alsa/asoundlib.h sys/asoundlib.h asound:snd_pcm_open
	config_cache nas audio/audiolib.h audio/soundlib.h
	config_cache xml libxml/parser.h libxslt/pattern.h libxslt/transform.h
	config_cache ldap ldap.h lber.h
	config_cache dbus dbus/dbus.h
	config_cache hal hal/libhal.h
	config_cache jpeg jpeglib.h
	config_cache oss sys/soundcard.h machine/soundcard.h soundcard.h
	config_cache lcms lcms.h

	strip-flags

	use amd64 && multilib_toolchain_setup x86

	#	$(use_enable amd64 win64)
	econf \
		--sysconfdir=/etc/wine \
		$(use_with ncurses curses) \
		$(use_with opengl) \
		$(use_with X x) \
		|| die "configure failed"

	emake -j1 depend || die "depend"
	emake all || die "all"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS ChangeLog DEVELOPERS-HINTS README
}

pkg_postinst() {
	elog "~/.wine/config is now deprecated.  For configuration either use"
	elog "winecfg or regedit HKCU\\Software\\Wine"
}
