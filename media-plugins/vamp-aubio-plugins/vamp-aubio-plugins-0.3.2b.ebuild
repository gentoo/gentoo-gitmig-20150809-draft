# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vamp-aubio-plugins/vamp-aubio-plugins-0.3.2b.ebuild,v 1.7 2009/05/09 18:11:19 aballier Exp $

inherit flag-o-matic toolchain-funcs multilib eutils

DESCRIPTION="Onset detection, pitch tracking, note tracking and tempo tracking plugins"
HOMEPAGE="http://www.vamp-plugins.org/"
SRC_URI="mirror://sourceforge/vamp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND=">=media-libs/aubio-0.3.2
	media-libs/vamp-plugin-sdk
	=sci-libs/fftw-3*"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	tc-export CXX
	# It only builds a shared library for a plugin
	# So we force PIC
	append-flags -fPIC -DPIC
	# Use shared libs
	sed -i -e "s/ -Wl,-Bstatic//" Makefile
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/vamp
	doins vamp-aubio.so vamp-aubio.cat
	dodoc README
}
