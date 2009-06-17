# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/calcchecksum/calcchecksum-1.6_pre1-r1.ebuild,v 1.3 2009/06/17 20:06:05 fauli Exp $

ARTS_REQUIRED="never"

WANT_AUTOMAKE="1.6"

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CalcChecksum is a tool for calculating MD5 and CRC32, TIGER, HAVAL, SHA and some other checksums."
HOMEPAGE="http://calcchecksum.sourceforge.net/"
SRC_URI="mirror://sourceforge/calcchecksum/${MY_P}.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

need-kde 3.5

PATCHES=(
	"${FILESDIR}/${P}+gcc-4.3.patch"
	"${FILESDIR}/calcchecksum-1.6_pre1-desktop-file.diff"
	)

src_unpack(){
	kde_src_unpack
	rm -f "${S}"/configure
}
