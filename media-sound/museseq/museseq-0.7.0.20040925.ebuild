# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/museseq/museseq-0.7.0.20040925.ebuild,v 1.2 2004/10/19 06:14:42 eradicator Exp $

IUSE="fluidsynth ladcca debug"

inherit eutils kde-functions

need-qt 3

MY_P=${P/museseq/muse}

DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="http://lmuse.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${MY_P}

DEPEND=">=x11-libs/qt-3.2.0
	>=media-libs/alsa-lib-0.9.0
	fluidsynth?	( media-sound/fluidsynth )
	app-text/openjade
	app-doc/doxygen
	media-gfx/graphviz
	dev-lang/perl
	>=media-libs/libsndfile-1.0.0
	>=media-sound/jack-audio-connection-kit-0.90.0
	ladcca?		( >=media-libs/ladcca-0.4.0 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34_typeid_fix.patch
}

src_compile() {
	econf --disable-suid-build \
			$(use_enable fluidsynth) \
			$(use_enable ladcca) \
			$(use_enable debug) \
		|| die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README SECURITY README.*
	mv ${D}/usr/bin/muse ${D}/usr/bin/museseq
}

pkg_postinst() {
	einfo "You must have the realtime module loaded to use MusE 0.7.x"
	einfo "Additionally, configure your Linux Kernel for non-generic"
	einfo "Real Time Clock support enabled or loaded as a module."
	einfo "User must have read/write access to /dev/misc/rtc device."
	einfo "Realtime LSM: http://sourceforge.net/projects/realtime-lsm/"
}
