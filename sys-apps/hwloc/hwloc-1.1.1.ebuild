# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwloc/hwloc-1.1.1.ebuild,v 1.1 2011/01/26 19:43:12 jsbronder Exp $

EAPI=2

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="http://www.open-mpi.org/software/hwloc/v1.1/downloads/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo svg static-libs xml X"
SLOT="0"
LICENSE="BSD"

RDEPEND="sys-libs/ncurses
	cairo? ( x11-libs/cairo[X?,svg?] )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${P} \
		$(use_enable cairo) \
		$(use_enable static-libs static) \
		$(use_enable xml) \
		$(use_with X x) \
		--disable-silent-rules
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README VERSION || die
}

src_test() {
	# autotools-utils broke tests, the first of which being
	# PASS: 256ppc-8n8s4t-nosys.output
	emake check || die
}
