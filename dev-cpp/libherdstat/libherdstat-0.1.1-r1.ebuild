# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libherdstat/libherdstat-0.1.1-r1.ebuild,v 1.9 2008/05/12 01:19:46 halcy0n Exp $

inherit eutils

TEST_DATA_PV="20051023"
TEST_DATA_P="${PN/lib/}-test-data-${TEST_DATA_PV}"

DESCRIPTION="C++ library offering interfaces for portage-related things such as Gentoo-specific XML files, package searching, and version sorting"
HOMEPAGE="http://developer.berlios.de/projects/libherdstat/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2
	test? ( mirror://berlios/${PN}/${TEST_DATA_P}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc sparc x86"
IUSE="debug doc curl test"

RDEPEND=">=dev-libs/xmlwrapp-0.5.0
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"
RDEPEND="${RDEPEND}
	!curl? ( net-misc/wget )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-fix-locale-longdesc.diff" \
		"${FILESDIR}/${P}-project_xml.patch" \
		"${FILESDIR}/${P}-gcc-4.3.patch"
}

src_compile() {
	econf \
		--with-test-data="${WORKDIR}/${TEST_DATA_P}" \
		--enable-static \
		$(use_enable test tests) \
		$(use_enable debug) \
		$(use_with curl) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc ; then
		emake docs || die "failed to build API docs"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO NEWS

	if use doc ; then
		dohtml -r doc/${PV}/html/*
		doman doc/${PV}/man/*/*.[0-9]
	fi
}
