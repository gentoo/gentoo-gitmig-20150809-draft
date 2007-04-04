# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.8.1.ebuild,v 1.4 2007/04/04 18:29:52 armin76 Exp $

IUSE="kmid tse3"

inherit kde eutils

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://noteedit.berlios.de/"
SRC_URI="http://download.berlios.de/noteedit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND="kmid? ( || ( kde-base/kmid kde-base/kdemultimedia )  )
	tse3? ( >=media-libs/tse3-0.3.1 )"

need-kde 3

pkg_setup() {
	use tse3 || use kmid || myconf="--without-libs"
	use kmid && myconf="${myconf} --with-libkmid-include=$KDEDIR/include"
	use kmid && myconf="${myconf} --with-libkmid-libs=$KDEDIR/$(get_libdir)"
	myconf="$(use_with tse3 libtse3)\
		$(use_with kmid libkmid) ${myconf}"

	kde_pkg_setup
}

src_install() {
	kde_src_install
	dodoc FAQ FAQ.de
	docinto examples
	dodoc noteedit/examples/*
}
