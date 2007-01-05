# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/museseq/museseq-0.6.2-r1.ebuild,v 1.13 2007/01/05 17:42:00 flameeyes Exp $

IUSE="jack fluidsynth ladcca doc alsa"

inherit virtualx eutils kde-functions

MY_P=muse-${PV}
DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="http://www.muse-sequencer.org/"
SRC_URI="mirror://sourceforge/lmuse/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc"

DEPEND="alsa? ( media-libs/alsa-lib )
	>=media-libs/libsndfile-1.0.4
	$(qt_min_version 3.1)
	ladcca? ( >=media-libs/ladcca-0.4.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	fluidsynth? ( media-sound/fluidsynth )
	doc? ( app-text/openjade
		app-text/docbook-dsssl-stylesheets )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s/HAVE_JACK_JACK_H/HAVE_JACK/" widgets/audioconf.cpp
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" driver/alsaaudio.cpp
	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/${P}-int2ptr.patch
	epatch ${FILESDIR}/${P}-memory.patch
	epatch ${FILESDIR}/${P}-drumport.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	local myconf
	myconf="--disable-suid-build"
	use ladcca || myconf="${myconf} --disable-ladcca"
	use jack || myconf="${myconf} --disable-jack"
	use fluidsynth || myconf="${myconf} --disable-fluidsynth"
	if use doc ; then
		# bug 49381
		local stylesheets="$(echo /usr/share/sgml/docbook/dsssl-stylesheets-*)"
		myconf="${myconf} --with-docbook-stylesheets=${stylesheets}"
	fi
	Xeconf ${myconf} || die "configure failed"

	### borrowed from kde.eclass #
	#
	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox,
	# so that the build process can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p $T/fakehome/.kde
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	#addwrite "${QTDIR}/etc/settings"
	# commented this out, proper fix is need-qt 3 from 
	# kde-functions.
	# Danny van Dyk <kugelfang@gentoo.org> 2004/05/26

	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"

	# Allow access to /dev/dri/card*
	addpredict /dev/dri/card*

	emake || die
	use doc && ( cd doc ; make manual )
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.softsynth SECURITY TODO

	mv ${D}/usr/share/muse/html ${D}/usr/share/doc/${PF}/html
	dosym /usr/share/doc/${PF}/html /usr/share/muse/html
	use doc && dohtml doc/*

	# Name conflict with media-sound/muse.  See bug #34973
	mv ${D}/usr/bin/muse ${D}/usr/bin/lmuse
	if [ ! -f /usr/bin/muse -o -L /usr/bin/muse ]; then
		dosym /usr/bin/lmuse /usr/bin/muse
	fi
}

pkg_postinst() {
	elog
	elog "Muse has been installed normally. If,"
	elog "you would like to use muse with real time"
	elog "time capabilities for the sequencer then do"
	elog "chmod 4755 /usr/bin/lmuse"
	elog
	elog "Muse can use /dev/rtc if it is compiled in"
	elog "to your kernel, or available as a module."
	elog
}
