# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/terminatorx/terminatorx-3.81.ebuild,v 1.17 2007/01/05 20:09:02 flameeyes Exp $

inherit gnome2

MY_P=${P/terminatorx/terminatorX}
S=${WORKDIR}/${MY_P}
DESCRIPTION='realtime audio synthesizer that allows you to "scratch" on digitally sampled audio data'
HOMEPAGE="http://www.terminatorx.org/"
SRC_URI="http://www.terminatorx.org/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc"
IUSE="3dnow alsa mpeg vorbis oss sox"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9 )
	mpeg? ( media-sound/madplay )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	sox? ( media-sound/sox )
	>=x11-libs/gtk+-2.2.0
	>=dev-libs/glib-2.2.0
	|| ( ( x11-libs/libXi
			x11-libs/libXxf86dga )
		virtual/x11 )
	dev-libs/libxml
	media-libs/audiofile
	media-libs/ladspa-sdk
	media-libs/ladspa-cmt
	app-text/scrollkeeper
	media-libs/liblrdf"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
			x11-proto/xf86dgaproto )
		virtual/x11 )"

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
	use vorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis" \
		|| myconf="${myconf} --disable-ogg123"
	use oss \
		&& myconf="${myconf} --enable-oss" \
		#|| myconf="${myconf} --disable-oss" # Doesn't work
	use sox \
		&& myconf="${myconf} --enable-sox" \
		|| myconf="${myconf} --disable-sox"

	econf ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	elog "Since Version 3.73 terminatorX supports running"
	elog "suid root. If you install the terminatorX binary"
	elog "suid root it will then create the engine thread"
	elog "with realtime priority."
	ewarn "Please read http://www.terminatorx.cx/faq.html#11"
	ewarn "for details and potential security risks."
}
