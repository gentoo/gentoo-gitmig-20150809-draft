# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/museseq/museseq-0.6.2.ebuild,v 1.2 2003/12/05 15:48:15 torbenh Exp $

inherit virtualx

MY_P=muse-${PV}
DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="http://muse.seh.de"
SRC_URI="mirror://sourceforge/lmuse/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="jack fluidsynth ladcca"

DEPEND="media-libs/alsa-lib \
	media-sound/alsa-utils \
	>=media-libs/libsndfile-1.0.4 \
	>=x11-libs/qt-3.1.0
	ladcca? ( media-libs/ladcca ) \
	jack? ( virtual/jack ) \
	fluidsynth? ( media-sound/fluidsynth )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s/HAVE_JACK_JACK_H/HAVE_JACK/" widgets/audioconf.cpp
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" driver/alsaaudio.cpp
}

src_compile() {
	local myconf
	myconf="--disable-suid-build"
	use ladcca || myconf="${myconf} --disable-ladcca"
	use jack || myconf="${myconf} --disable-jack"
	use fluidsynth || myconf="${myconf} --disable-fluidsynth"
	Xeconf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING INSTALL README README.softsynth SECURITY TODO
}

pkg_postinst() {
	einfo ""
	einfo "Muse has been installed normally. If,"
	einfo "you would like to use muse with real time"
	einfo "time capabilities for the sequencer then do"
	einfo "chmod 4755 /usr/bin/muse"
	einfo ""
	einfo "Muse can use /dev/rtc if it is compiled in"
	einfo "to your kernel, or available as a module."
	einfo ""
}

