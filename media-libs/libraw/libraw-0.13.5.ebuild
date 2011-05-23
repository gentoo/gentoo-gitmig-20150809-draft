# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libraw/libraw-0.13.5.ebuild,v 1.1 2011/05/23 21:55:55 radhermit Exp $

EAPI="4"

inherit eutils autotools

MY_P="LibRaw-${PV}"
DESCRIPTION="LibRaw is a library for reading RAW files obtained from digital photo cameras"
HOMEPAGE="http://www.libraw.org/"
SRC_URI="http://www.libraw.org/data/${MY_P}.tar.gz
	demosaic? ( https://github.com/LibRaw/LibRaw-demosaic-pack-GPL2/tarball/${PV} -> LibRaw-demosaic-pack-GPL2-${PV}.tar.gz
		https://github.com/LibRaw/LibRaw-demosaic-pack-GPL3/tarball/${PV} -> LibRaw-demosaic-pack-GPL3-${PV}.tar.gz )"

# Libraw also has it's own license, which is a pdf file and
# can be obtained from here:
# http://www.libraw.org/data/LICENSE.LibRaw.pdf
LICENSE="LGPL-2.1 CDDL GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demosaic examples +lcms +openmp"

DEPEND="lcms? ( media-libs/lcms:2 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( Changelog.txt README )

src_unpack() {
	unpack ${A}
	if use demosaic ; then
		mv *LibRaw-demosaic*GPL2* LibRaw-demosaic-pack-GPL2-${PV}
		mv *LibRaw-demosaic*GPL3* LibRaw-demosaic-pack-GPL3-${PV}
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.13.4-docs.patch
	epatch "${FILESDIR}"/${PN}-0.13.4-examples.patch
	eautomake
}

src_configure() {
	econf \
		$(use_enable demosaic demosaic-pack-gpl2) \
		$(use_enable demosaic demosaic-pack-gpl3) \
		$(use_enable examples) \
		$(use_enable lcms) \
		$(use_enable openmp)
}
