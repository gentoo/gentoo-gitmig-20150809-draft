# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mumble/mumble-1.1.1.ebuild,v 1.3 2008/01/06 20:55:23 drizzt Exp $

inherit eutils toolchain-funcs qt4

DESCRIPTION="Voice chat software for gaming written in Qt4"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio vanilla"

DEPEND="$(qt4_min_version 4.3)
	>=media-libs/speex-1.2_beta3
	media-libs/alsa-lib
	dev-libs/boost
	x11-libs/libXevie
	pulseaudio? ( media-sound/pulseaudio )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use -a =x11-libs/qt-4* sqlite3 dbus ; then
		echo
		if ! built_with_use =x11-libs/qt-4* sqlite3; then
			eerror "You need to build Qt4 with the sqlite3 use-flag"
		fi
		if ! built_with_use =x11-libs/qt-4* dbus; then
			eerror "You need to build Qt4 with the dbus use-flag"
		fi
		echo
		die "Your Qt4 installation lacks propper useflag configuration, see above"
	fi

	if [[ $(gcc-major-version) -eq 3 && $(gcc-minor-version) -lt 4 ]]; then
		eerror "You need >=sys-devel/gcc-3.4 to compile ${PN}."
		die "System gcc is too old to compile ${PN}."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	use pulseaudio || sed -i -e '/CONFIG  += oss/s/ pulseaudio//' \
		"${S}"/src/mumble/mumble.pro || die
	use vanilla || epatch "${FILESDIR}"/${P}-path.patch

	sed -i -e '/LIBS /s/-lspeex/& -lspeexdsp/' \
		"${S}"/src/mumble/mumble.pro || die
}

src_compile() {
	local dir
	for dir in src/mumble overlay_gl; do
		cd "${S}/$dir"
		qmake ${dir##*/}.pro	|| die "qmake failed"
		lrelease ${dir##*/}.pro || die "lrelease failed"
		emake CC="$(tc-getCC) ${CFLAGS}" \
			CXX="$(tc-getCXX) ${CXXFLAGS}" \
			LINK="$(tc-getCXX)" || die "emake failed"
	done
}

src_install() {
	newdoc README.Linux README
	dodoc CHANGES

	local dir
	if built_with_use =x11-libs/qt-4* debug; then
		dir=debug
		ewarn "Built debug-version because your Qt4 has the debug use-flag enabled."
	else
		dir=release
	fi

	dobin ${dir}/mumble	|| die "installing failed"
	dolib.so ${dir}/lib*.so* || die "installing failed"

	dobin scripts/mumble-overlay || die "installing failed"
	newicon icons/mumble.64x64.png mumble.png || die "installing icon failed"
	make_desktop_entry ${PN} "Mumble" mumble.png "KDE;Qt;AudioVideo" \
		|| die "installing menu entry failed"
}

pkg_postinst() {
	elog
	elog "Visit http://mumble.sourceforge.net/Audio_Tuning for futher configuration"
	elog "type mumble to run the client"
	elog "you might want to add this to your xorg.conf to get shortcut support"
	elog "  Section \"Extensions\""
	elog "   Option         \"XEVIE\" \"Enable\""
	elog "  EndSection"
}
