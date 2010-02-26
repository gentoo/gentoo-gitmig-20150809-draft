# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ncbi-tools++/ncbi-tools++-2009.05.15-r2.ebuild,v 1.1 2010/02/26 16:07:02 weaver Exp $

EAPI="2"

inherit eutils multilib

MY_TAG="May_15_2009"
MY_Y="${MY_TAG/*_/}"
MY_P="ncbi_cxx--${MY_TAG}"

DESCRIPTION="NCBI C++ Toolkit, including NCBI BLAST+"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/books/bv.fcgi?rid=toolkit"
SRC_URI="ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools++/${MY_Y}/${MY_TAG}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
#IUSE="X unicode opengl gnutls test"
IUSE="sqlite"
KEYWORDS="~amd64 ~x86"

# wxGTK: must run eselect wxwindows after installing wxgtk or build will fail. Check and abort here.
# dev-libs/xalan-c - problems detecting, api mismatch?

# apparently gbench-only dependencies
#	dev-libs/libxml2
#	dev-libs/libxslt
#	dev-libs/xerces-c
#	dev-libs/lzo:2
#	dev-libs/boost
#	app-text/sablotron
#	media-libs/libpng
#	media-libs/tiff
#	media-libs/jpeg
#	x11-libs/libXpm
#	unicode? ( dev-libs/icu )
#	opengl? ( media-libs/glut
#		media-libs/mesa )
#	gnutls? ( net-libs/gnutls )
#	X? ( x11-libs/fltk:1.1
#		x11-libs/wxGTK )

DEPEND="sqlite? ( dev-db/sqlite:3 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	sed -i -e 's/-print-file-name=libstdc++.a//' src/build-system/configure
}

src_configure() {
	# econf fails
	# --with-bin-release and --without-ftds are workarounds for build system bugs
	# NB: build system supports ICC
	"${S}"/configure --without-debug \
		--with-bin-release \
		--without-static \
		--with-dll \
		--without-ftds \
		--prefix="${D}"/usr \
		--libdir="${D}"/usr/$(get_libdir)/${PN} \
		--with-z="/usr" \
		--with-bz2="/usr" \
		--with-pcre="/usr" \
		--with-openssl="/usr" \
		|| die

#		--with-mt \ # fails with gcc-4.4 but not 4.3

# apparently gbench-only configs
#		--with-boost="/usr" \
#		--with-sablot="/usr" \
#		--with-icu="/usr" \
#		--with-fltk="/usr" \
#		--with-mesa="/usr" \
#		--with-glut="/usr" \
#		--with-wxwidgets="/usr" \
# problems detecting this
#		--with-xalan="/usr" \
}

src_compile() {
	emake all_r -C GCC*-Release*/build || die
}

src_install() {
	emake install || die
	# File collisions with sci-biology/ncbi-tools
	rm -f "${D}"/usr/bin/{asn2asn,rpsblast,test_regexp}

	echo "LD_LIBRARY_PATH=/usr/lib/${PN}" > ${S}/99${PN}
	doenvd "${S}/99${PN}"
}

pkg_postinst() {
	einfo 'Please run "source /etc/profile" before using this package in the current shell.'
}
