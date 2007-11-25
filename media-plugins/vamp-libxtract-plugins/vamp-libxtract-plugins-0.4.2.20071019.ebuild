# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vamp-libxtract-plugins/vamp-libxtract-plugins-0.4.2.20071019.ebuild,v 1.3 2007/11/25 02:42:04 ranger Exp $

inherit multilib toolchain-funcs

DESCRIPTION="Low-level feature extraction plugins using Jamie Bullock's libxtract library to provide around 50 spectral and other features"
HOMEPAGE="http://www.vamp-plugins.org/"
SRC_URI="mirror://sourceforge/vamp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="=sci-libs/fftw-3*
	media-libs/libxtract
	media-libs/vamp-plugin-sdk"
RDEPEND="${DEPEND}"

src_compile() {
	tc-export CXX
	sed -i -e "s/-O2 -march=pentium3 -mfpmath=sse/-fPIC -DPIC/" Makefile
	sed -i -e "s/ -Wl,-Bstatic//" Makefile
	emake || die "make failed"
}

src_install() {
	insinto /usr/$(get_libdir)/vamp
	doins vamp-libxtract.{so,cat}
	dodoc README STATUS
}
