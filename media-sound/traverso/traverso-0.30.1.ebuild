# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/traverso/traverso-0.30.1.ebuild,v 1.5 2007/03/25 12:48:54 aballier Exp $

inherit eutils qt4 toolchain-funcs

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://traverso-daw.org/"
SRC_URI="http://traverso-daw.org/download/releases/${P}.tar.gz"

IUSE="alsa jack sse"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(qt4_min_version 4)
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	media-libs/libsndfile
	media-libs/libsamplerate"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nojack.patch"

	# remove exec stacks
	mv "${S}/src/engine/sse_functions.s" "${S}/src/engine/sse_functions.S"
	epatch "${FILESDIR}/${P}-execstack.patch"


	use jack || sed -ie "s:^\(DEFINES\ +=\ JACK_SUPPORT.*\):#\1:" src/base.pri
	use alsa || sed -ie "s:^\(DEFINES\ +=\ ALSA_SUPPORT.*\):#\1:" src/base.pri
	use sse || sed -ie "s:^\(.*DEFINES\ +=\ SSE_OPTIMIZATIONS.*\):#\1:" src/base.pri
	sed -ie "s:^\(\#define\ RESOURCES_DIR\) \(.*\):\1 \"/usr/share/traverso\":" src/config.h
	sed -ie "s:^\(target.path\ =\) \(.*\):\1 /usr/bin:" src/traverso/traverso.pro
	sed -ie "s:^\(DESTDIR_TARGET\ =\) \(.*\):\1 /usr/bin:" src/traverso/traverso.pro
	#  Removing forced cxxflags
	sed -ie "s:^\(.*QMAKE_CXXFLAGS_RELEASE.*\):#\1:" src/base.pri
	# adding our cxxflags
	sed -ie "s:^\(.*release\ {.*\):\1\n QMAKE_CXXFLAGS_RELEASE\ =\ ${CXXFLAGS}:" src/base.pri
}

src_compile() {
	QMAKE="/usr/bin/qmake"
	$QMAKE traverso.pro -after "QMAKE_STRIP=\"/usr/bin/true\"" || die "qmake failed"
	# No no, this is not a typo, LFLAGS is what they use as LDFLAGS...
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) LINK=$(tc-getCXX) LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
