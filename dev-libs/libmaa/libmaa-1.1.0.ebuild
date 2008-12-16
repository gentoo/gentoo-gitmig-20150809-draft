# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmaa/libmaa-1.1.0.ebuild,v 1.3 2008/12/16 17:07:33 jer Exp $

inherit eutils

DESCRIPTION="Library with low-level data structures which are helpful for writing compilers"
HOMEPAGE="http://www.dict.org/"
SRC_URI="mirror://sourceforge/dict/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-LDFLAGS.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README doc/libmaa.600dpi.ps || die
}
