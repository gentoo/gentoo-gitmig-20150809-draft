# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbida/fbida-2.03-r1.ebuild,v 1.1 2005/03/23 14:02:51 spock Exp $

DESCRIPTION="Image viewers for the framebuffer console (fbi) and X11 (ida)."
HOMEPAGE="http://linux.bytesex.org/fbida/"
SRC_URI="http://dl.bytesex.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="png jpeg gif tiff curl lirc X fbcon"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 virtual/motif )
	!media-gfx/fbi
	media-libs/libexif"

src_unpack() {
	unpack ${A}
	sed -e 's/DGifOpenFileName,ungif/DGifOpenFileName,gif/' \
	    -e 's/-lungif/-lgif/' -i ${S}/GNUmakefile
}

src_compile() {
	# let autoconf do its job and then fix things to build fbida
	# according to our specifications
	emake Make.config || die

	set_feat() {
		local useflag=${1}
		local config=${2}

		if ! use ${useflag}; then
			sed -e "s/${config}.*/${config} := no/" -i ${S}/Make.config
		fi
	}

	set_feat fbcon 	HAVE_LINUX_FB_H
	set_feat X 		HAVE_MOTIF
	set_feat tiff 	HAVE_LIBTIFF
	set_feat png 	HAVE_LIBPNG
	set_feat gif 	HAVE_LIBUNGIF
	set_feat lirc 	HAVE_LIBLIRC
	set_feat curl 	HAVE_LIBCURL

	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		prefix=/usr \
		install || die
	dodoc README
}
