# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koverartist/koverartist-0.5-r1.ebuild,v 1.2 2009/06/13 14:30:53 tampakrap Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Koverartist is a KDE program for fast creation of covers for cd/dvd cases and boxes."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=38195"
SRC_URI="http://members.inode.at/499177/software/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cddb"

DEPEND="!app-cdr/kover"
RDEPEND="${DEPEND}
	cddb?  ( || ( ( kde-base/libkcddb:3.5 kde-base/kdemultimedia-kioslaves:3.5 )
			kde-base/kdemultimedia:3.5 ) )"
need-kde 3.5

S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/koverartist-0.5-gcc43b.patch"
	"${FILESDIR}/koverartist-0.5-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="$(use_with cddb audiocd)"
	kde_src_compile
}
