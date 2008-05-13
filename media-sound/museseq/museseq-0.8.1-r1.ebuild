# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/museseq/museseq-0.8.1-r1.ebuild,v 1.7 2008/05/13 05:35:43 drac Exp $

inherit kde-functions virtualx eutils

MY_P=${P/museseq/muse}
MY_P=${MY_P/_/}
REV="a"

DESCRIPTION="MusE is a MIDI/Audio sequencer with recording and editing capabilities"
SRC_URI="mirror://sourceforge/lmuse/${MY_P}${REV}.tar.gz"
HOMEPAGE="http://www.muse-sequencer.org/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="doc lash debug"

RDEPEND="$(qt_min_version 3.2)
	>=media-libs/alsa-lib-0.9.0
	media-sound/fluidsynth
	dev-lang/perl
	>=media-libs/libsndfile-1.0.1
	>=media-libs/libsamplerate-0.1.0
	>=media-sound/jack-audio-connection-kit-0.98.0
	lash? ( media-sound/lash )"
DEPEND="${RDEPEND}
	doc? ( app-text/openjade
		app-doc/doxygen
		media-gfx/graphviz )"

src_compile() {
	cd "${WORKDIR}/${MY_P}"
	local myconf
	myconf="--disable-suid-build" # instead, use CONFIG_RTC and realtime-lsm
	use lash		&& myconf="${myconf} --enable-lash"
	use lash		|| myconf="${myconf} --disable-lash"
	use debug		&& myconf="${myconf} --enable-debug"
	Xeconf "${myconf}" || die "configure failed"

	emake all || die
}

src_install() {
	cd "${WORKDIR}/${MY_P}"
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README SECURITY README.*
	mv "${D}/usr/bin/muse" "${D}/usr/bin/museseq"
}

pkg_postinst() {
	elog "You must have the realtime module loaded to use MusE 0.8.x"
	elog "Additionally, configure your Linux Kernel for non-generic"
	elog "Real Time Clock support enabled or loaded as a module."
	elog "User must have read/write access to /dev/misc/rtc device."
	elog "Realtime LSM: http://sourceforge.net/projects/realtime-lsm/"
}
