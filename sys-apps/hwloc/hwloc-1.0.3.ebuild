# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwloc/hwloc-1.0.3.ebuild,v 1.2 2011/01/24 16:14:03 xarthisius Exp $

EAPI=2

inherit autotools-utils

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="http://www.open-mpi.org/software/hwloc/v1.0/downloads/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo svg static-libs xml X"
SLOT="0"
LICENSE="BSD"

RDEPEND="sys-libs/ncurses
	cairo? ( x11-libs/cairo[X?,svg?] )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS NEWS README VERSION )

src_configure() {
	myeconfargs=(
		$(use_enable cairo)
		$(use_enable static-libs static)
		$(use_enable xml)
		$(use_with X x)
		--disable-silent-rules
	)
	autotools-utils_src_configure
}
