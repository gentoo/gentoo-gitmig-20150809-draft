# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

IUSE="alsa jpeg encode ffmpeg xvid lirc xosd"

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"
S="${WORKDIR}/${P}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

RDEPEND="virtual/x11
	>=media-libs/zvbi-0.2.4
	|| ( x11-libs/neXtaw x11-libs/Xaw3d )
	x86? ( >=media-libs/divx4linux-20030428 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
	xvid? ( >=media-libs/xvid-0.9.1 )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( media-libs/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( media-libs/alsa-lib media-sound/alsa-utils )
	xosd? ( >=x11-libs/xosd-2.2.2 )"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	local myconf

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use lirc \
		&& myconf="${myconf} --enable-lirc" \
		|| myconf="${myconf} --disable-lirc"

	use x86 \
		&& myconf="${myconf} --enable-divx4linux" \
		|| myconf="${myconf} --disable-divx4linux"

	use ffmpeg \
		&& myconf="${myconf} --enable-ffmpeg" \
		|| myconf="${myconf} --disable-ffmpeg"

	use xvid \
		&& myconf="${myconf} --enable-xvid" \
		|| myconf="${myconf} --disable-xvid"

	use xosd \
		&& myconf="${myconf} --enable-xosd" \
		|| myconf="${myconf} --disable-xosd"

	econf ${myconf} || die "Configuration failed."

	emake PERF_FLAGS="${CFLAGS}" || die "Compilation failed."
	# Or should we keep the optimized flags they suggest?
	#emake || die "Compilation failed."
}

src_install() {

	sed -i "/^SUBDIRS=/s:font::" Makefile

	insinto /usr/X11R6/lib/X11/fonts/misc
	doins font/led-fixed.pcf

	insinto /usr/share/applications
	doins gentoo/xawdecode.desktop

	einstall \
		ROOT=${D} || die "Installation failed."

	dodoc COPYING ChangeLog AUTHORS INSTALL
	dodoc FAQ* README.* lisez-moi*
	dodoc xawdecoderc.sample
	dodoc lircrc.*.sample

}

pkg_postinst() {
	einfo "Please note that this ebuild created a suid-binary:"
	einfo "/usr/bin/xawdecode_v4l-conf"
}
