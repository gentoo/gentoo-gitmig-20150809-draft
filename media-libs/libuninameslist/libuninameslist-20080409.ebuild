# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuninameslist/libuninameslist-20080409.ebuild,v 1.3 2008/07/16 12:24:11 fmccor Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Library of unicode annotation data"
SRC_URI="mirror://sourceforge/libuninameslist/${P}.tar.bz2"
HOMEPAGE="http://libuninameslist.sourceforge.net/"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
DEPEND=""
RDEPEND=""
IUSE=""

src_install() {
	emake DESTDIR="${D}" install
}
