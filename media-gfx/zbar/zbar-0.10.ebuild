# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zbar/zbar-0.10.ebuild,v 1.1 2011/10/03 16:13:50 xmw Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python

DESCRIPTION="Library and tools for reading barcodes from images or video"
HOMEPAGE="http://zbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/zbar/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk imagemagick jpeg python qt4 static-libs +threads v4l v4l2 X xv"

RDEPEND="gtk? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	imagemagick? ( >=media-gfx/imagemagick-6.2.6 )
	jpeg? ( virtual/jpeg )
	python? ( gtk? ( dev-python/pygtk )	)
	qt4? ( x11-libs/qt-core x11-libs/qt-gui )
	X? ( x11-libs/libXext
		xv? ( x11-libs/libXv ) )"

DEPEND="${RDEPEND}"

src_configure() {
	local conf="--disable-video"
	if use v4l || use v4l2 ; then
		conf="--enable-video"
	fi

	econf ${conf} \
		$(use_with jpeg) \
		$(use_with gtk) \
		$(use_with imagemagick) \
		$(use_with python) \
		$(use_with qt4 qt) \
		$(use_enable static-libs static) \
		$(use_enable threads pthread) \
		$(use_with X x) \
		$(use_with xv xv)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc HACKING NEWS README TODO || die
	rm -r "${D}"/usr/share/doc/${PN} || die
	find "${D}" -name "*.la" -delete || die
}
