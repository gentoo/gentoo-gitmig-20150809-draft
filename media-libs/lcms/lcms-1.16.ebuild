# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.16.ebuild,v 1.4 2007/03/27 11:12:20 uberlord Exp $

inherit libtool eutils

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="tiff jpeg zlib python"

DEPEND="tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( >=dev-lang/python-1.5.2 >=dev-lang/swig-1.3.31 )"
		# ugly workaround because arches have not keyworded it
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We need to refresh this for the BSD's
	cp /usr/share/libtool/install-sh .

	elibtoolize

	# run swig to regenerate lcms_wrap.cxx and lcms.py (bug #148728)
	if use python; then
		cd "${S}"/python
		./swig_lcms || die "swig_lcms failed"
	fi
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with jpeg) \
		$(use_with tiff) \
		$(use_with zlib) \
		$(use_with python) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		BINDIR="${D}"/usr/bin \
		install || die "make install failed"

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	dodoc AUTHORS README* INSTALL NEWS doc/*
}
