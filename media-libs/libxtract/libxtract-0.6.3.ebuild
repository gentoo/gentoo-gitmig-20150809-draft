# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libxtract/libxtract-0.6.3.ebuild,v 1.3 2013/04/04 08:26:55 aballier Exp $

DESCRIPTION="A simple, portable, lightweight library of audio feature extraction functions"
HOMEPAGE="http://libxtract.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc fftw static-libs"

RDEPEND="fftw? ( =sci-libs/fftw-3* )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf \
		$(use_enable fftw fft) \
		$(use_enable static-libs static)
	# Prevent doc from being generated automagically
	use doc || touch doc/doxygen-build.stamp
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	find "${D}" -name "*.la" -delete
	dodoc README TODO AUTHORS
	use doc && dohtml doc/html/*
}
