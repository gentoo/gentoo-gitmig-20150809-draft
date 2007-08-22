# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/traverso/traverso-0.41.0-r1.ebuild,v 1.3 2007/08/22 07:56:14 aballier Exp $

inherit eutils qt4 toolchain-funcs

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://traverso-daw.org/"
SRC_URI="http://traverso-daw.org/download/gentoo/${P}-1.tar.gz"

IUSE="alsa jack lv2 opengl sse"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(qt4_min_version 4.3.1)
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	>=dev-libs/glib-2.8
	>=media-libs/libsndfile-1.0.12
	media-libs/libsamplerate
	>=sci-libs/fftw-3
	lv2? ( dev-libs/rasqal dev-libs/redland )"

DEPEND="${RDEPEND}
	sys-apps/sed"

pkg_setup() {
	if use opengl && ! built_with_use =x11-libs/qt-4* opengl; then
		eerror "You need to build qt4 with opengl support to have it in ${PN}"
		die "Enabling opengl for traverso requires qt4 to be built with opengl support"
	fi
}

S="${WORKDIR}/${P}-1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -ie "s:^\(\#define\ RESOURCES_DIR\) \(.*\):\1 \"/usr/share/traverso\":" src/config.h
	sed -ie "s:^\(target.path\ =\) \(.*\):\1 /usr/bin:" src/traverso/traverso.pro
	sed -ie "s:^\(DESTDIR_TARGET\ =\) \(.*\):\1 /usr/bin:" src/traverso/traverso.pro
	#  Removing forced cxxflags
	sed -ie "s:^\(.*QMAKE_CXXFLAGS_RELEASE.*\):#\1:" src/base.pri
	# adding our cxxflags
	sed -ie "s:^\(.*release\ {.*\):\1\n QMAKE_CXXFLAGS_RELEASE\ =\ ${CXXFLAGS}:" src/base.pri
}

src_compile() {
	use jack || echo "DEFINES -= JACK_SUPPORT" >> src/base.pri
	use alsa || echo "DEFINES -= ALSA_SUPPORT" >> src/base.pri
	use sse || echo "DEFINES -= SSE_OPTIMIZATIONS" >> src/base.pri
	use lv2 || echo "DEFINES -= LV2_SUPPORT" >> src/base.pri
	use opengl || echo "DEFINES -= QT_OPENGL_SUPPORT" >> src/base.pri

	QMAKE="/usr/bin/qmake"
	$QMAKE -recursive traverso.pro -after "QMAKE_STRIP=\"/usr/bin/true\"" || die "qmake failed"
	emake -j1 CC=$(tc-getCC) CXX=$(tc-getCXX) LINK=$(tc-getCXX) || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README resources/help.text
	doicon resources/freedesktop/icons/128x128/apps/traverso.png
	domenu resources/traverso.desktop
}
