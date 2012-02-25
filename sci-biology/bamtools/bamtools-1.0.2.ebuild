# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bamtools/bamtools-1.0.2.ebuild,v 1.1 2012/02/25 17:46:03 weaver Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="BamTools provides both a programmer's API and an end-user's toolkit for handling BAM files."
HOMEPAGE="https://github.com/pezmaster31/bamtools"
SRC_URI="https://github.com/downloads/pezmaster31/bamtools/"${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_install() {
	for i in bin/bamtools-${PV} lib/libbamtools.so.${PV} lib/libbamtools-utils.so.${PV}; do
		TMPDIR="$(pwd)" scanelf -Xr $i || die
	done

	dobin bin/bamtools || die
	dolib lib/* || die
	insinto /usr/include/bamtools/api || die
	doins include/api/* || die
	insinto /usr/include/bamtools/shared || die
	doins include/shared/*
	dodoc README || die
}
