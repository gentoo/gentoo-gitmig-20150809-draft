# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koverartist/koverartist-0.5.ebuild,v 1.11 2009/06/13 14:30:53 tampakrap Exp $

inherit kde eutils

DESCRIPTION="Koverartist is a KDE program for fast creation of covers for cd/dvd cases and boxes."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=38195"
SRC_URI="http://members.inode.at/499177/software/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ppc sparc x86"
IUSE="cddb"

DEPEND="!app-cdr/kover
	cddb?  ( || ( ( =kde-base/libkcddb-3.5* =kde-base/kdemultimedia-kioslaves-3.5* )
			=kde-base/kdemultimedia-3.5* ) )"

need-kde 3.3

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	if ! use cddb ; then
		myconf="$myconf --without-audiocd"
	fi
	kde_src_compile
}
