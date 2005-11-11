# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.10.ebuild,v 1.8 2005/11/11 23:00:17 hansmi Exp $

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ~ppc-macos ~ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libdvdread"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
