# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdebian-installer/libdebian-installer-0.74-r1.ebuild,v 1.2 2010/10/25 22:41:46 hwoarang Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Library of common debian-installer functions"
HOMEPAGE="http://packages.qa.debian.org/libd/libdebian-installer.html"
SRC_URI="mirror://debian/pool/main/libd/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

DEPEND=" doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-warnings.patch" \
		"${FILESDIR}/${P}-dont-install-docs.patch" \
		"${FILESDIR}/${P}-doubling-readsize-support-oe.patch"
}

src_configure() {
	econf --disable-static
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		emake -C doc doc || die "emake for docs failed"
	fi
	rm -f "${D}"/usr/$(get_libdir)/*la || die
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	if use doc; then
		dohtml -r doc/html/*
	fi

	dodoc HACKING debian/changelog
}
