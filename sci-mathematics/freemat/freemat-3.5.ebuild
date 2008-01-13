# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/freemat/freemat-3.5.ebuild,v 1.4 2008/01/13 14:52:50 bicatali Exp $

inherit flag-o-matic qt4

MY_PN=FreeMat
MY_P=${MY_PN}-${PV}

DESCRIPTION="Environment for rapid engineering and scientific processing"
HOMEPAGE="http://freemat.sourceforge.net/"
SRC_URI="mirror://sourceforge/freemat/${MY_P}.tar.gz"

IUSE="ncurses ffcall fftw umfpack arpack portaudio"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="$(qt4_min_version 4.2)
	dev-libs/libpcre
	virtual/lapack
	ncurses? ( >=sys-libs/ncurses-5.4 )
	umfpack? ( sci-libs/umfpack )
	arpack? ( sci-libs/arpack )
	fftw? ( >=sci-libs/fftw-3 )
	portaudio? ( media-libs/portaudio )"

RDEPEND="${DEPEND}
	ffcall? ( dev-libs/ffcall )"

DEPEND="dev-util/pkgconfig"

QT4_BUILT_WITH_USE_CHECK="opengl"
S="${WORKDIR}/${MY_P}"

src_compile() {
	# -O3 still doesn't compile freemat-3.5
	replace-flags -O3 -O2
	econf \
		--with-blas="(pkg-config --libs blas)" \
		--with-lapack="(pkg-config --libs lapack)" \
		$(use_with ncurses) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog || die "dodoc failed"
}

pkg_postint() {
	einfo "Initializing freemat data directory"
	FreeMat -i "${ROOT}"/usr/share/${MY_P}
}
