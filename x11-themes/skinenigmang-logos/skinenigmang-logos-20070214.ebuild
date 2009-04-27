# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/skinenigmang-logos/skinenigmang-logos-20070214.ebuild,v 1.3 2009/04/27 23:58:44 hd_brummy Exp $

inherit eutils

DESCRIPTION="VDR - Skin Plugin: enigma-ng logos"
HOMEPAGE="http://andreas.vdr-developer.org/enigmang/download.html"
SRC_URI="!dxr3? ( http://andreas.vdr-developer.org/enigmang/download/${PN}-xpm-hi-${PV}.tgz )
		dxr3? ( http://andreas.vdr-developer.org/enigmang/download/${PN}-xpm-lo-${PV}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="dxr3"

RDEPEND="media-plugins/vdr-skinenigmang"

S=${WORKDIR}/skinenigmang

src_install() {

	insinto /usr/share/vdr/skinenigmang
	cp -r -a "${S}"/* --target="${D}"/usr/share/vdr/skinenigmang
}
