# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zynaddsubfx/zynaddsubfx-2.4.0.ebuild,v 1.3 2011/03/20 20:06:18 jlec Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_P=ZynAddSubFX-${PV}

DESCRIPTION="ZynAddSubFX is an opensource software synthesizer."
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
SRC_URI="mirror://sourceforge/zynaddsubfx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="oss alsa jack lash +fltk"

RDEPEND="
	sci-libs/fftw:3.0
	fltk? ( x11-libs/fltk:1 )
	jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( media-libs/alsa-lib )
	lash? ( media-sound/lash )
	>=dev-libs/mini-xml-2.2.1"
#	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/CXXFLAGS +=/s:CXXFLAGS +=:override CXXFLAGS +=:' \
		-e '/export CXXFLAGS/d' \
		-e '/\$(MAKE) -C UI/s:$: CXXFLAGS="${CXXFLAGS}":' \
		-e '/\$(MAKE) -C $@/s:$: CXXFLAGS="${CXXFLAGS}":' \
		"${S}/src/Makefile" || die "unable to reset CXXFLAGS overrides."
	sed -e 's/gcc -g/$(CC) $(CFLAGS)/' \
		-e 's/gcc -o/$(CC) $(LDFLAGS) -o/' \
		-i "${S}/ExternalPrograms/Spliter/Makefile" || die
	sed -e 's/gcc -o/$(CC) $(LDFLAGS) -o/' \
		-e 's/gcc/$(CC) $(CFLAGS)/' \
		-i "${S}/ExternalPrograms/Controller/Makefile" || die
	epatch "${FILESDIR}/${P}-string.patch"
	epatch "${FILESDIR}/${P}-ldflags.patch"
	epatch "${FILESDIR}/${P}-nullmidiin.patch"
}

use_echo_yesno() {
	if use $1 ; then
		echo "YES"
	else
		echo "NO"
	fi
}

src_configure() {
	cd "${S}/src"
	echo "OS_PORT=LINUX" > Makefile.inc
	echo "FFTW_VERSION=3" >> Makefile.inc
	echo "ASM_F2I=NO" >> Makefile.inc
	echo "DISABLE_GUI=$(use_echo_yesno !fltk)" >> Makefile.inc
	if use oss ; then
		use alsa || echo "MIDIIN=OSS" >> Makefile.inc
		if use jack; then
			echo "AUDIOOUT=OSS_AND_JACK" >> Makefile.inc
		else
			echo "AUDIOOUT=OSS" >> Makefile.inc
		fi
	else
		if use jack; then
			echo "AUDIOOUT=JACK" >> Makefile.inc
		else
			echo "AUDIOOUT=NONE" >> Makefile.inc
		fi
	fi
	if use alsa ;  then
		echo "MIDIIN=ALSA" >> Makefile.inc
	else
		use oss || echo "MIDIIN=NONE" >> Makefile.inc
	fi
	echo "LINUX_USE_LASH=$(use_echo_yesno lash)" >> Makefile.inc
}

src_compile() {
	tc-export CC CXX

	cd "${S}/src"
	emake -j1 \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		|| die "compile failed"
	if use fltk ; then
		cd "${S}/ExternalPrograms/Spliter"
		emake || die
		cd "${S}/ExternalPrograms/Controller"
		emake || die
	fi
}

src_install() {
	dobin "${S}/src/zynaddsubfx"
	use fltk && dobin "${S}/ExternalPrograms/Spliter/spliter"
	use fltk && dobin "${S}/ExternalPrograms/Controller/controller"
	dodoc ChangeLog FAQ.txt HISTORY.txt README.txt ZynAddSubFX.lsm bugs.txt

	insinto "/usr/share/${PN}"
	doins -r "${S}/banks" "${S}/examples"
}
