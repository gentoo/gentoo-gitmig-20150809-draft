# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.3.0.ebuild,v 1.2 2010/11/08 17:41:42 xarthisius Exp $

EAPI="3"
inherit base

MY_P=${P/_rc/RC}

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://geotiff.osgeo.org/"
SRC_URI="http://download.osgeo.org/geotiff/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc static-libs"

RDEPEND="
	virtual/jpeg
	>=media-libs/tiff-3.9.1
	sci-libs/proj
	sys-libs/zlib"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P/RC*/}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-debug=$(use debug && echo yes || echo no) \
		--with-jpeg=/usr/ \
		--with-zip=/usr/

}
src_compile() {
	base_src_compile

	if use doc; then
		mkdir -p docs/api
		cp "${FILESDIR}"/Doxyfile Doxyfile
		doxygen -u Doxyfile || die "updating doxygen config failed"
		doxygen Doxyfile || die "docs generation failed"
	fi
}

src_install() {
	base_src_install

	dodoc README ChangeLog || die
	use doc && { dohtml docs/api/* || die ; }
}

pkg_postinst() {
	echo
	ewarn "You should rebuild any packages built against ${PN} by running:"
	ewarn "# revdep-rebuild"
	ewarn "or using preserved-rebuild features of portage-2.2:"
	ewarn "# emerge @preserved-rebuild"
	echo
}
