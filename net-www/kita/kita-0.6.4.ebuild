# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kita/kita-0.6.4.ebuild,v 1.1 2003/12/02 17:42:39 usata Exp $

IUSE=""

PVMAJOR="`echo ${PV} | cut -d'.' -f1`"
PVMINOR="`echo ${PV} | cut -d'.' -f2`"
PVMICRO="`echo ${PV} | cut -d'.' -f3`"
MY_PV="${PVMAJOR}.${PVMINOR}${PVMICRO}"

MY_P="${PN}-${MY_PV}"

DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/7044/${MY_P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.1
	>=kde-base/kde-3.1
	>=kde-base/kdelibs-3.1
	kde-base/arts
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg"
#RDEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-close-gentoo.diff
}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
