# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbida/fbida-2.03.ebuild,v 1.3 2005/03/23 14:06:39 spock Exp $

DESCRIPTION="Image viewers for the framebuffer console (fbi) and X11 (ida)."
HOMEPAGE="http://linux.bytesex.org/fbida/"
SRC_URI="http://dl.bytesex.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="png jpeg gif tiff curl lirc X fbcon"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/giflib media-libs/libungif )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 virtual/motif )
	media-libs/libexif
	!media-gfx/fbi"

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
