# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/terminatorX/terminatorX-3.80.ebuild,v 1.1 2003/06/25 10:41:17 torbenh Exp $

S=${WORKDIR}/${P}
DESCRIPTION='terminatorX is a realtime audio synthesizer that allows you to "scratch" on digitally sampled audio data'
HOMEPAGE="http://www.terminatorx.cx/"
SRC_URI="http://www.terminatorx.cx/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="3dnow alsa mpeg oggvorbis oss sox"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.9 )
	mpeg? ( media-sound/mad )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	sox? ( media-sound/sox )
	>=x11-libs/gtk+-2.2.0
	>=dev-libs/glib-2.2.0
	>=x11-base/xfree-4.2.0-r11
	dev-libs/libxml
	media-libs/audiofile
	media-libs/ladspa-sdk
	media-libs/ladspa-cmt
	app-text/scrollkeeper
	media-libs/liblrdf"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/terminatorX-3.80.GNOMEpresent.patch
	epatch ${FILESDIR}/terminatorX-3.80.fixGnomeMakefile.patch
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
		&& myconf="${myconf} --enable-sox"

	WANT_AUTOMAKE_1_6=1 econf ${myconf}

	make || die
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	echo "
Since Version 3.73 terminatorX supports
running suid root. If you install the terminatorX binary suid
root with the following commands:

> chown root /usr/bin/terminatorX
> chmod u+s /usr/bin/terminatorX

terminatorX will then create the engine thread with realtime
priority.

There is a small chance that a malicious attacker could
utilize terminatorX to acquire root privileges if installed suid
root, although it should require quite some effort to create an
exploit for that. On the other hand realtime scheduling
massively improves the playback performance. So depending on who
can access your computer you will have to decide for yourself on
performance vs security.
"
}
