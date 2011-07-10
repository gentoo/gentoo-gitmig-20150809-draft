# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libharu/libharu-2.1.0.ebuild,v 1.3 2011/07/10 15:49:38 jlec Exp $

DESCRIPTION="C/C++ library for PDF generation"
HOMEPAGE="http://www.libharu.org/"
SRC_URI="http://libharu.org/files/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="png zlib examples"

DEPEND="
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_with png) \
		$(use_with zlib)
	emake || die "emake failed"
}

src_install() {
	emake \
		INSTALL_STRIP_FLAG="" \
		DESTDIR="${D}" install || die "emake install failed"
	dodoc README CHANGES
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demo/* || die
	fi
}
