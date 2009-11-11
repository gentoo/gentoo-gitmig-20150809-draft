# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/klibido/klibido-0.2.5.ebuild,v 1.11 2009/11/11 12:38:56 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde db-use

DESCRIPTION="KDE Linux Binaries Downloader"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://klibido.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ppc x86"
IUSE="debug"

RDEPEND=">=sys-libs/db-4.1"
DEPEND="${RDEPEND}
	dev-libs/uulib"

need-kde 3

PATCHES=(
	"${FILESDIR}"/${P}-gcc4.1.diff
	"${FILESDIR}"/${P}+gcc-4.3.patch
)

src_unpack() {
	kde_src_unpack

	dbincldir="$(db_includedir 4.8 4.7 4.6 4.5 4.4 4.3 4.2 4.1)" || die "unable to find db"
	einfo "db include dir = ${dbincldir}"

	if [ ! -d ${dbincldir} ]; then
		die "db include dir does not exist"
	fi

	sed -i \
		-e "s,-I/usr/include/db4,-I${dbincldir}," \
		 "${S}"/src/Makefile.am

	rm -f "${S}"/configure
}

src_compile() {
	myconf="${myconf}
		$(use_enable debug)
	"
	kde_src_compile
}
