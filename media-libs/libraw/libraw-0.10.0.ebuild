# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libraw/libraw-0.10.0.ebuild,v 1.1 2010/09/19 08:16:02 hollow Exp $

EAPI="2"

inherit eutils

DESCRIPTION="LibRaw is a library for reading RAW files obtained from digital photo cameras"
HOMEPAGE="http://www.libraw.org/"
SRC_URI="http://www.libraw.org/data/LibRaw-${PV}.tar.gz"

# Libraw also has it's own license, which is a pdf file and
# can be obtained from here:
# http://www.libraw.org/data/LICENSE.LibRaw.pdf
LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lcms openmp examples"

RDEPEND="lcms? ( =media-libs/lcms-1* )"

S="${WORKDIR}/LibRaw-${PV}"

src_prepare() {
	# Add pkg-config support
	epatch "${FILESDIR}/libraw-0.10.0-pkg-config.patch"

	sed -i -e "s:/usr/local/:${D}usr/:g" \
		-e "/^CFLAGS/ s:-O4:${CFLAGS}:" \
		Makefile

	if use lcms; then
		sed -i -r '/^#LCMS/ s!^#!!' Makefile
		sed -i -r -e '/^Libs/ s!$! -llcms!' \
			-e '/^Requires/ s!$! lcms2!' *.pc
	fi

	if use openmp; then
		sed -i -r '/^CFLAGS/ s!^(.*)$!\1 -fopenmp!' Makefile
		sed -i -r -e '/^Cflags/ s!$! -fopenmp!' \
			-e '/^Libs/ s!$! -lgomp!' *.pc
	fi
}

src_install() {
	# This makefile doesn't even make the directories..
	mkdir -p "${D}usr/include" "${D}usr/lib" "${D}usr/lib/pkgconfig" \
		$(use examples && echo "${D}/usr/bin") || die "Directory making failed."

	emake install \
		$(use examples && echo "install-binaries") || die "Install failed."
}
