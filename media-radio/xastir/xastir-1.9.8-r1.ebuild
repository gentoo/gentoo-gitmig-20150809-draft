# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xastir/xastir-1.9.8-r1.ebuild,v 1.2 2010/10/10 18:43:46 ulm Exp $

EAPI=2
inherit autotools eutils multilib

DESCRIPTION="X Amateur Station Tracking and Information Reporting"
HOMEPAGE="http://xastir.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="festival gdal geotiff imagemagick"

DEPEND=">=x11-libs/openmotif-2.3:0
	x11-libs/libXpm
	x11-apps/xfontsel
	dev-libs/libpcre
	net-misc/curl
	sys-libs/db
	sci-libs/shapelib
	geotiff? ( sci-libs/proj
		sci-libs/libgeotiff
		media-libs/tiff )
	gdal? ( sci-libs/gdal )
	imagemagick? ( media-gfx/imagemagick )
	festival? ( app-accessibility/festival )"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix hardcoded /usr/local paths in scripts
	epatch "${FILESDIR}"/${P}-scripts.diff
	# and patch libdir
	for f in scripts/permutations.pl scripts/test_coord.pl \
		scripts/toporama250k.pl scripts/toporama50k.pl; do
		sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" "${f}" \
			|| die "sed failed on ${f}"
	done

	# fix __FORTIFY_SOURCE warning (bug #337365)
	epatch 	"${FILESDIR}"/${P}-fortify.diff

	# fix for DESTDIR
	epatch 	"${FILESDIR}"/${P}-Destdir.diff

	eautoreconf
}

src_configure() {
	econf --without-graphicsmagick \
		--with-pcre \
		--with-shapelib \
		--with-dbfawk \
		--without-ax25 \
		--without-gpsman \
		$(use_with geotiff libproj) \
		$(use_with geotiff) \
		$(use_with gdal) \
		$(use_with imagemagick) \
		$(use_with festival)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog FAQ README README.Contributing \
		README.Getting-Started README.MAPS || die "dodoc failed"
}

pkg_postinst() {
	elog "Kernel mode AX.25 and GPSman library not supported."
	elog
	elog "Remember you have to be root to add addditional scripts,"
	elog "maps and other configuration data under /usr/share/xastir"
	elog "and /usr/$(get_libdir)/xastir."
}
