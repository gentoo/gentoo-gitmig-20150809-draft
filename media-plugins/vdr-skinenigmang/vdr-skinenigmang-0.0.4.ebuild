# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinenigmang/vdr-skinenigmang-0.0.4.ebuild,v 1.1 2007/04/02 19:45:42 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR - Skin Plugin: enigma-ng"
HOMEPAGE="http://andreas.vdr-developer.org/enigmang/"
SRC_URI="http://andreas.vdr-developer.org/enigmang/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick"

DEPEND=">=media-video/vdr-1.3.44"

RDEPEND="${DEPEND}
		x11-themes/skinenigmang-logos
		imagemagick? ( media-gfx/imagemagick )"


S=${WORKDIR}/skinenigmang-${PV}

src_unpack() {
	vdr-plugin_src_unpack

	use imagemagick && sed -i "s:#HAVE_IMAGEMAGICK:HAVE_IMAGEMAGICK:" Makefile
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/themes
	doins ${S}/themes/*
}
