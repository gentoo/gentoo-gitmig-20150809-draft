# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.16.ebuild,v 1.3 2004/12/05 01:00:44 iggy Exp $

inherit myth

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="opengl debug nls"

DEPEND=">=sys-apps/sed-4
	opengl? ( virtual/opengl )
	media-libs/tiff
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_compile() {
	econf `use_enable opengl` || die

	myth_src_compile
}
