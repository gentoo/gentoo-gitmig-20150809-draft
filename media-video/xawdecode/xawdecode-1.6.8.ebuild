# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/xawdecode/xawdecode-1.6.8.ebuild,v 1.1 2003/05/19 02:41:38 seemant Exp $

inherit eutils

IUSE="alsa jpeg dga encode"

S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver allowing decoding"
HOMEPAGE="http://xawdecode.sourceforge.net/"
SRC_URI="mirror://sourceforge/xawdecode/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-apps/sed-4.0.5"

RDEPEND="virtual/x11
	media-libs/divx4linux
	media-video/avifile
	encode? ( media-sound/lame )
	jpeg? ( media-libs/jpeg )
	alsa? ( media-libs/alsa-lib )"


src_compile() {
	local myconf
	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use dga \
		&& myconf="${myconf} --enable-xfree-ext" \
		|| myconf="${myconf} --disable-xfree-ext"


	# if lame is installed xawdecode will use it (there's no configure-flag)
	# if lirc is installed it will also be used
	# the same goes for ffmpeg libraries (not media-video/ffmpeg)
	#   (don't know how to install them)

	econf ${myconf} || die

	emake PERF_FLAGS2="${CFLAGS}" || die
}

src_install() {
	
	sed -i \
		"s:^SUBDIRS.*:SUBDIRS = alevt src:" Makefile
	
	insinto /usr/X11R6/lib/X11/fonts/misc
	doins font/led-fixed.pcf

	einstall \
		ROOT=${D} || die

	dodoc COPYING ChangeLog
	dodoc FAQ* README.* lisez-moi*
	dodoc xawdecoderc.sample

}

pkg_postinst() {
	einfo "Please note that this ebuild created a suid-binary: /usr/bin/v4l-conf"
}
