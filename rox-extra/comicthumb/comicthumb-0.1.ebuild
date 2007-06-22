# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/comicthumb/comicthumb-0.1.ebuild,v 1.2 2007/06/22 21:42:16 lack Exp $

ROX_VER="2.1.1"
ROX_LIB_VER="2.0.2"
inherit rox

MY_PN="ComicThumb"
DESCRIPTION="Thumbnailer for rox, which generates thumbnails for archived comix files."
HOMEPAGE="http://www.theli.ho.com.ua/"
SRC_URI="http://www.theli.ho.com.ua/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="rar"
KEYWORDS="~amd64 ~x86"

RDEPEND="rar? ( app-arch/unrar )
	dev-python/imaging"

APPNAME=${MY_PN}
S=${WORKDIR}
