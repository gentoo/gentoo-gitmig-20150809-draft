# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bb/bb-1.3.0_rc1-r1.ebuild,v 1.1 2012/01/28 19:25:23 slyfox Exp $

EAPI=4

inherit autotools eutils versionator

MY_P="${PN}-$(get_version_component_range 1-2)$(get_version_component_range 4-4)"

DESCRIPTION="Demonstration program for visual effects of aalib"
HOMEPAGE="http://aa-project.sourceforge.net/"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mikmod"

DEPEND="media-libs/aalib
	mikmod? ( media-libs/libmikmod )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	epatch "${FILESDIR}/${P}-noattr.patch"
	epatch "${FILESDIR}/${P}-fix-protos.patch"

	# rename binary and manpage bb -> bb-aalib

	mv bb.1 bb-aalib.1 || die
	sed -e 's/bb/bb-aalib/' \
		-i bb-aalib.1
	sed -e 's/bin_PROGRAMS = bb/bin_PROGRAMS = bb-aalib/' \
	    -e 's/man_MANS = bb.1/man_MANS = bb-aalib.1/'     \
	    -e 's/bb_SOURCES/bb_aalib_SOURCES/'               \
		-i Makefile.am || die

	eautoreconf
}

pkg_postinst() {
	elog "bb binary has been renamed to bb-aalib to avoid a naming conflict with sys-apps/busybox."
}
