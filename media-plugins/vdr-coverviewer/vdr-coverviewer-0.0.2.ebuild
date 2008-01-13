# Copyright 2003-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-coverviewer/vdr-coverviewer-0.0.2.ebuild,v 1.1 2008/01/13 16:43:10 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: coverviewer for vdr-music"
HOMEPAGE="http://www.vdr.glaserei-franz.de/"
SRC_URI="http://www.kost.sh/vdr/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="imagemagick"

PATCHES="${FILESDIR}/${P}-vdr-1.5.x.diff"

DEPEND="imagemagick? ( media-gfx/imagemagick )
		!imagemagick? ( media-libs/imlib2 )"

RDEPEND="=media-plugins/vdr-music-0.2.0"

src_unpack() {
	vdr-plugin_src_unpack

	use imagemagick && sed -i Makefile -e "s:#HAVE_MAGICK=1:HAVE_MAGICK=1:"
}
