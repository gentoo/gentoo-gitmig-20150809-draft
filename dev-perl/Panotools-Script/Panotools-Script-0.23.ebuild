# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Panotools-Script/Panotools-Script-0.23.ebuild,v 1.1 2009/12/21 15:24:11 tove Exp $

EAPI="2"

MODULE_AUTHOR=BPOSTLE
inherit perl-module

DESCRIPTION="A perl module for reading, writing, and manipulating hugin script files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gui"

RDEPEND="dev-perl/GraphViz
	>=dev-perl/ImageSize-2.9
	>=media-libs/exiftool-6
	gui? ( gnome-extra/zenity )"
DEPEND=""

SRC_TEST="do"

src_install() {
	perl-module_src_install
	if use gui ; then
		insinto /usr/share/applications
		doins "${S}"/desktop/*.desktop || die
	else
		rm "${D}"/usr/bin/*-gui || die
	fi
}

pkg_postinst() {
	einfo "Some of the scripts require 'nona', 'freepv', 'enblend', 'autotrace', and"
	einfo "ImageMagick command-line tools which are available in the following"
	einfo "packages: media-gfx/hugin, media-gfx/freepv, media-gfx/enblend,"
	einfo "media-gfx/autotrace, and media-gfx/imagemagick."
}
