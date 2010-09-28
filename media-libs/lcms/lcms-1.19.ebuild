# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.19.ebuild,v 1.9 2010/09/28 16:19:42 ssuominen Exp $

EAPI=2
inherit libtool multilib

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="jpeg python static-libs tiff zlib"

RDEPEND="tiff? ( media-libs/tiff )
	jpeg? ( virtual/jpeg )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.31 )"

src_prepare() {
	# run swig to regenerate lcms_wrap.cxx and lcms.py (bug #148728)
	if use python; then
		cd python
		./swig_lcms || die
	fi
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_with jpeg) \
		$(use_with python) \
		$(use_with tiff) \
		$(use_with zlib)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		BINDIR="${D}"/usr/bin \
		libdir=/usr/$(get_libdir) \
		install || die

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	dodoc AUTHORS README* INSTALL NEWS doc/*

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
