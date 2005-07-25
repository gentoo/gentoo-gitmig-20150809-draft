# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/museseq/museseq-0.7.0-r1.ebuild,v 1.5 2005/07/25 15:54:45 caleb Exp $

inherit kde-functions virtualx eutils

MY_P=${P/museseq/muse}
DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
SRC_URI="mirror://sourceforge/lmuse/${MY_P}.tar.bz2"
HOMEPAGE="http://lmuse.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
#IUSE="fluidsynth doc ladcca sdk debug"
IUSE="fluidsynth doc ladcca debug"

DEPEND="$(qt_min_version 3.2)
	>=media-libs/alsa-lib-0.9.0
	fluidsynth?	( media-sound/fluidsynth )
	doc? ( app-text/openjade
		   app-doc/doxygen
		   media-gfx/graphviz )
	dev-lang/perl
	>=media-libs/libsndfile-1.0.0
	>=media-sound/jack-audio-connection-kit-0.90.0
	ladcca?		( >=media-libs/ladcca-0.4.0 )"
#	sdk?		( >=media-libs/fst-1.6-r1 )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${MY_P}
	epatch ${FILESDIR}/${P}-suidinstall.patch
}

src_compile() {
	cd ${WORKDIR}/${MY_P}
	local myconf
	myconf="--disable-suid-build" # instead, use CONFIG_RTC and realtime-lsm
	use fluidsynth	|| myconf="${myconf} --disable-fluidsynth"
	use ladcca		|| myconf="${myconf} --disable-ladcca"
#	use sdk			&& myconf="${myconf} --enable-vst"
	use debug		&& myconf="${myconf} --enable-debug"

	Xeconf ${myconf} || die "configure failed"

	emake || die
}

src_install() {
	cd ${WORKDIR}/${MY_P}
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.CVS README.de README.instruments README.ladspaguis README.shortcuts README.softsynth README.translate SECURITY
	mv ${D}/usr/bin/muse ${D}/usr/bin/museseq
}

pkg_postinst() {
	einfo "You must have the realtime module loaded to use MusE 0.7.x"
	einfo "Additionally, your Linux Kernel must have the non-generic"
	einfo "Real Time Clock support enabled or loaded as a module."
	einfo "Realtime LSM: http://sourceforge.net/projects/realtime-lsm/"
}

