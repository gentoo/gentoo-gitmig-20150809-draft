# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinenigmang/vdr-skinenigmang-0.0.6.ebuild,v 1.3 2009/04/28 00:00:28 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR - Skin Plugin: enigma-ng"
HOMEPAGE="http://andreas.vdr-developer.org/enigmang/"
SRC_URI="http://andreas.vdr-developer.org/enigmang/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE="imagemagick"

DEPEND=">=media-video/vdr-1.3.44"

RDEPEND="${DEPEND}
		x11-themes/skinenigmang-logos
		imagemagick? ( media-gfx/imagemagick )"

S=${WORKDIR}/skinenigmang-${PV}

src_unpack() {
	vdr-plugin_src_unpack

	use imagemagick && sed -i "s:#HAVE_IMAGEMAGICK:HAVE_IMAGEMAGICK:" Makefile

	# TODO: implement a clean query / extra tool vdr-config
	sed -i -e '/^VDRLOCALE/d' Makefile
	if has_version ">=media-video/vdr-1.5.9"; then
		sed -i -e 's/.*$(VDRLOCALE).*/ifeq (1,1)/' Makefile
	fi

	has_version ">=media-gfx/imagemagick-6.4" && epatch "${FILESDIR}/imagemagick-6.4.x.diff"
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/themes
	doins "${S}"/themes/*
}
