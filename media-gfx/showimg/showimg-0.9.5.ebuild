# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.5.ebuild,v 1.5 2006/09/04 05:57:46 tsunam Exp $

inherit kde eutils

MY_PV="${PV/?.?.?.?/${PV%.*}-${PV##*.}}"
MY_P="${PN}-${MY_PV}"
MY_P=${P/_/-}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ShowImg is a feature-rich image viewer for KDE  including an image management system."
HOMEPAGE="http://www.jalix.org/projects/showimg/"
#SRC_URI="http://www.jalix.org/projects/showimg/download/.0.9.5/distributions/SVN_info/${MY_P}.tar.bz2"
SRC_URI="http://www.jalix.org/projects/showimg/download/${MY_PV}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="exif kipi mysql postgres"


DEPEND="|| ( kde-base/libkonq kde-base/kdebase )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/libpq dev-libs/libpqxx )
	exif? ( media-libs/libkexif )
	kipi? ( media-plugins/kipi-plugins )
	media-libs/libexif"
need-kde 3.4

src_compile(){
	local myconf="--with-showimgdb \
		$(use_enable exif kexif) \
		$(use_enable kipi libkipi) \
		$(use_with mysql) \
		$(use_with postgres pgsql)"
	kde_src_compile all
}
