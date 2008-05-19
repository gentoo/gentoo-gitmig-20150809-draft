# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.5.ebuild,v 1.13 2008/05/19 20:05:17 dev-zero Exp $

inherit kde eutils

MY_PV="${PV/?.?.?.?/${PV%.*}-${PV##*.}}"
MY_P="${PN}-${MY_PV}"
MY_P=${P/_/-}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ShowImg is a feature-rich image viewer for KDE  including an image management system."
HOMEPAGE="http://www.jalix.org/projects/showimg/"
SRC_URI="http://www.jalix.org/projects/showimg/download/${MY_PV}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="exif kipi mysql postgres"

DEPEND="|| ( =kde-base/libkonq-3.5* =kde-base/kdebase-3.5* )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base dev-libs/libpqxx )
	exif? ( media-libs/libkexif )
	kipi? ( media-plugins/kipi-plugins )
	media-libs/libexif"
need-kde 3.4

PATCHES=(
	"${FILESDIR}/${P}-as-needed.patch"
	"${FILESDIR}/${P}+gcc-4.3.patch"
	)

src_compile() {
	local myconf="--with-showimgdb \
		$(use_with exif kexif) \
		$(use_enable kipi libkipi) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql)"
	kde_src_compile all
}
