# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbida/fbida-2.03.ebuild,v 1.5 2006/01/22 14:54:50 spock Exp $

DESCRIPTION="Image viewers for the framebuffer console (fbi) and X11 (ida)."
HOMEPAGE="http://linux.bytesex.org/fbida/"
SRC_URI="http://dl.bytesex.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="png jpeg gif tiff curl lirc X fbcon"

RDEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( || ( ( x11-libs/libX11 x11-libs/libXt x11-libs/libXpm )
			virtual/x11 )
		virtual/motif )
	media-libs/libexif
	!media-gfx/fbi"

DEPEND="${RDEPEND}
	X? ( || ( ( x11-proto/xextproto x11-proto/xproto )
			virtual/x11 ) )"

src_compile() {
	# let autoconf do its job and then fix things to build fbida
	# according to our specifications
	emake Make.config || die
	if ! use fbcon; then
		sed -e 's/HAVE_LINUX_FB_H.*/HAVE_LINUX_FB_H := no/' -i ${S}/Make.config
	fi
	if ! use X; then
		sed -e 's/HAVE_MOTIF.*/HAVE_MOTIF := no/'  -i ${S}/Make.config
	fi
	if ! use tiff; then
		sed -e 's/HAVE_LIBTIFF.*/HAVE_LIBTIFF := no/'  -i ${S}/Make.config
	fi
	if ! use png; then
		sed -e 's/HAVE_LIBPNG.*/HAVE_LIBPNG := no/'  -i ${S}/Make.config
	fi
	if ! use gif; then
		sed -e 's/HAVE_LIBUNGIF.*/HAVE_LIBUNGIF := no/'  -i ${S}/Make.config
	fi
	if ! use lirc; then
		sed -e 's/HAVE_LIBLIRC.*/HAVE_LIBLIRC := no/'  -i ${S}/Make.config
	fi
	if ! use curl; then
		sed -e 's/HAVE_LIBCURL.*/HAVE_LIBCURL := no/'  -i ${S}/Make.config
	fi

	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		prefix=/usr \
		install || die
	dodoc README
}
