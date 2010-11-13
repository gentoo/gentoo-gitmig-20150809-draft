# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwloc/hwloc-1.0.2.ebuild,v 1.2 2010/11/13 18:49:13 jer Exp $

EAPI=2

inherit base

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="http://www.open-mpi.org/software/hwloc/v1.0/downloads/${P}.tar.bz2"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="cairo svg xml X"
SLOT="0"
LICENSE="BSD"

RDEPEND="sys-libs/ncurses
	cairo? ( x11-libs/cairo[X?,svg?] )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS NEWS README VERSION )

src_configure() {
	econf \
		$(use_enable cairo) \
		$(use_enable xml) \
		$(use_with X x) \
		--disable-silent-rules
}
