# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/terminatorx/terminatorx-3.81.ebuild,v 1.6 2004/04/03 23:49:04 spyderous Exp $

inherit gnome2

MY_P=${P/terminatorx/terminatorX}
S=${WORKDIR}/${MY_P}
DESCRIPTION='realtime audio synthesizer that allows you to "scratch" on digitally sampled audio data'
HOMEPAGE="http://www.terminatorx.cx/"
SRC_URI="http://www.terminatorx.cx/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="3dnow alsa mpeg oggvorbis oss sox"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.9 )
	mpeg? ( media-sound/mad )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	sox? ( media-sound/sox )
	>=x11-libs/gtk+-2.2.0
	>=dev-libs/glib-2.2.0
	virtual/x11
	dev-libs/libxml
	media-libs/audiofile
	media-libs/ladspa-sdk
	media-libs/ladspa-cmt
	app-text/scrollkeeper
	media-libs/liblrdf"

src_unpack() {
	unpack ${A}
	cd ${S}

	# we need the omf fix, or else we get access violation
	# errors related to sandbox
	gnome2_omf_fix ${S}/doc/terminatorX-manual/C/Makefile.in

}

src_compile() {
	local myconf=""

	use 3dnow \
		&& myconf="${myconf} --enable-3dnow"
	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"
	use mpeg \
		&& myconf="${myconf} --enable-mad" \
		|| myconf="${myconf} --disable-mad" \
		|| myconf="${myconf} --disable-mpg123"
	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis" \
		|| myconf="${myconf} --disable-ogg123"
	use oss \
		&& myconf="${myconf} --enable-oss" \
		#|| myconf="${myconf} --disable-oss" # Doesn't work
	use sox \
		&& myconf="${myconf} --enable-sox" \
		|| myconf="${myconf} --disable-sox"

	econf ${myconf}

	emake || die
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	einfo "Since Version 3.73 terminatorX supports running"
	einfo "suid root. If you install the terminatorX binary"
	einfo "suid root it will then create the engine thread"
	einfo "with realtime priority."
	ewarn "Please read http://www.terminatorx.cx/faq.html#11"
	ewarn "for details and potential security risks."
}
