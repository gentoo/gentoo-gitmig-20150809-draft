# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.0.2.ebuild,v 1.3 2002/07/24 06:47:45 rphillips Exp $

inherit  kde-dist

DESCRIPTION="${DESCRIPTION}PIM"

DEPEND="$DEPEND sys-devel/perl"

newdepend "pda? ( >=dev-libs/pilot-link-0.9.0 )"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_unpack() {
    base_src_unpack

    cd ${S}
    patch -p0 < ${FILESDIR}/kdepim-qt-3.0.5.patch
}

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
