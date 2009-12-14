# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/ncview/ncview-1.93g.ebuild,v 1.2 2009/12/14 19:12:55 bicatali Exp $

EAPI=2
inherit eutils flag-o-matic

DESCRIPTION="X-based viewer for netCDF files"
SRC_URI="ftp://cirrus.ucsd.edu/pub/ncview/${P}.tar.gz"
HOMEPAGE="http://meteora.ucsd.edu/~pierce/ncview_home_page.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="udunits"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="sci-libs/netcdf
	media-libs/netpbm
	x11-libs/libXaw
	udunits? ( sci-libs/udunits )"
RDEPEND="${DEPEND}"

src_configure() {
	# Makefile doesn't actually respect --with-ppm_incdir
	append-flags -I/usr/include/netpbm
	# force netpbm (could be a use flag, but worth it?)
	econf \
		--x-libraries=/usr/$(get_libdir) \
		--x-include=/usr/include \
		--with-ppm_incdir=/usr/include/netpbm \
		$(use_with udunits)
}

src_compile() {
	emake NCVIEW_LIB_DIR="/usr/share/${PN}" || die "emake failed"
}

src_install() {
	local appdef=/usr/share/X11/app-defaults
	dodir ${appdef}
	dodir /usr/share/${PN}
	# fix when root installs it.
	sed -i \
		-e "s:/usr/lib/X11/app-defaults:${D}${appdef}:g" \
		install-appdef || die "sed failed"
	emake \
		DESTDIR="${D}" \
		BINDIR="${D}/usr/bin" \
		MANDIR="${D}/usr/share/man/man1" \
		NCVIEW_LIB_DIR="${D}/usr/share/${PN}" \
		XAPPLRESDIR="${D}/usr/share/X11/app-defaults" \
		install || die "emake install failed"
	insinto /usr/share/${PN}
	doins *.ncmap nc_overlay* || die "doins failed"
	dodoc README README_WISH_LIST RELEASE_NOTES || die
}
