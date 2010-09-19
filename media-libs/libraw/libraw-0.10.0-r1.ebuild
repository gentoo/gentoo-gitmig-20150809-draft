# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libraw/libraw-0.10.0-r1.ebuild,v 1.1 2010/09/19 20:13:44 hollow Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="LibRaw is a library for reading RAW files obtained from digital photo cameras"
HOMEPAGE="http://www.libraw.org/"
SRC_URI="http://www.libraw.org/data/LibRaw-${PV}.tar.gz"

# Libraw also has it's own license, which is a pdf file and
# can be obtained from here:
# http://www.libraw.org/data/LICENSE.LibRaw.pdf
LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lcms +openmp examples"

DEPEND="lcms? ( =media-libs/lcms-1* )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/LibRaw-${PV}"

src_prepare() {
	EPATCH_OPTS="-p1" \
	epatch "${FILESDIR}/libraw-0.10.0-autoconf.patch"

	sed -i -e "s/@@VERSION@@/${PV}/" configure.ac
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable openmp) \
		$(use_enable lcms)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
