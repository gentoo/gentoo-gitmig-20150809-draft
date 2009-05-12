# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.8.1-r3.ebuild,v 1.1 2009/05/12 15:32:20 ssuominen Exp $

EAPI=1

ARTS_REQUIRED="never"
LANGS_DOC="de"
USE_KEG_PACKAGING="yes"

inherit kde eutils

DESCRIPTION="Musical score editor."
HOMEPAGE="http://noteedit.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="kmid tse3"

DEPEND="kmid? ( || ( kde-base/kmid:3.5 kde-base/kdemultimedia:3.5 )  )
	tse3? ( >=media-libs/tse3-0.3.1 )"
RDEPEND="${DEPEND}"
need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-desktop-file.patch" "${FILESDIR}/${P}+gcc-4.3.patch" "${FILESDIR}/${P}+gcc-4.3.1.patch" "${FILESDIR}/${P}-mxmlexport.patch" )

src_compile() {
	use tse3 || use kmid || myconf="--without-libs"
	use kmid && myconf="${myconf} --with-libkmid-include=$KDEDIR/include
								  --with-libkmid-libs=$KDEDIR/$(get_libdir)"
	myconf="$(use_with tse3 libtse3) \
		$(use_with kmid libkmid) ${myconf}"

	rm -f "${S}/configure"
	kde_src_compile
}

src_install() {
	kde_src_install
	dodoc FAQ FAQ.de
	docinto examples
	dodoc noteedit/examples/*
}
