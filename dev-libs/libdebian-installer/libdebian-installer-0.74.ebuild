# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdebian-installer/libdebian-installer-0.74.ebuild,v 1.1 2010/07/29 17:15:42 darkside Exp $

EAPI=2
inherit eutils

DESCRIPTION="Library of common debian-installer functions"
HOMEPAGE="http://packages.qa.debian.org/libd/libdebian-installer.html"
SRC_URI="mirror://debian/pool/main/libd/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND=" doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-warnings.patch" \
		"${FILESDIR}/${P}-dont-install-docs.patch" \
		"${FILESDIR}/${P}-doubling-readsize-support-oe.patch"
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		emake -C doc doc || die "emake for docs failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	if use doc; then
		dohtml -r doc/html/*
	fi

	dodoc HACKING debian/changelog
}
