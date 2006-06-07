# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.10.ebuild,v 1.12 2006/06/07 23:04:00 flameeyes Exp $

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
