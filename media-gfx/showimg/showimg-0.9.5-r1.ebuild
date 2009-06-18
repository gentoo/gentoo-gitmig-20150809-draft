# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/showimg/showimg-0.9.5-r1.ebuild,v 1.3 2009/06/18 19:31:14 gentoofan23 Exp $

ARTS_REQUIRED="never"

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="exif kipi mysql postgres"

DEPEND="|| ( =kde-base/libkonq-3.5* =kde-base/kdebase-3.5* )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base >=dev-libs/libpqxx-2.6.9 )
	exif? ( media-libs/libkexif )
	kipi? ( media-plugins/kipi-plugins )
	media-libs/libexif"
need-kde 3.5

PATCHES=(
	"${FILESDIR}/showimg-0.9.5-as-needed.patch"
	"${FILESDIR}/showimg-0.9.5-gcc-4.3.patch"
	"${FILESDIR}/showimg-0.9.5-libpqxx-2.6.9.diff"
	)

src_unpack() {
	kde_src_unpack

	sed -i -e '/MimeType/s:$:;:' \
		"${S}/showimg/showimgapp/showimg.desktop" \
		|| die "Sed failed."
}

src_compile() {
	local myconf="--with-showimgdb \
		$(use_with exif kexif) \
		$(use_enable kipi libkipi) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql)"

	rm -f "${S}"/configure
	kde_src_compile all
}
