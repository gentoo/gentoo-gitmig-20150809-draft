# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kita/kita-0.6.1-r1.ebuild,v 1.1 2003/12/04 19:41:32 usata Exp $

IUSE=""

PVMAJOR="`echo ${PV} | cut -d'.' -f1`"
PVMINOR="`echo ${PV} | cut -d'.' -f2`"
PVMICRO="`echo ${PV} | cut -d'.' -f3`"
MY_PV="${PVMAJOR}.${PVMINOR}${PVMICRO}"

MY_P="${PN}-${MY_PV}"

DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/6388/${MY_P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="x86"

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
	epatch ${FILESDIR}/${PN}-0.6.4-close-gentoo.diff
	epatch ${FILESDIR}/${PN}-boardview-gentoo.diff
}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
