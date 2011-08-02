# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwloc/hwloc-1.2.ebuild,v 1.2 2011/08/02 11:37:34 xarthisius Exp $

EAPI="4"

inherit multilib versionator

MY_PV=v$(get_version_component_range 1-2)

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="http://www.open-mpi.org/software/${PN}/${MY_PV}/downloads/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux"
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
		--docdir="${EPREFIX}/usr/share/doc/${P}" \
		$(use_enable cairo) \
		$(use_enable static-libs static) \
		$(use_enable xml) \
		$(use_with X x) \
		--disable-silent-rules
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README VERSION
	use static-libs || rm "${D}"/usr/$(get_libdir)/lib${PN}.la
}
