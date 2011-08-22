# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdebian-installer/libdebian-installer-0.79.ebuild,v 1.1 2011/08/22 09:34:38 jer Exp $

EAPI=2

inherit autotools-utils eutils multilib

DESCRIPTION="Library of common debian-installer functions"
HOMEPAGE="http://packages.qa.debian.org/libd/libdebian-installer.html"
SRC_URI="mirror://debian/pool/main/libd/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND=" doc? ( app-doc/doxygen )"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.74-fix-warnings.patch" \
		"${FILESDIR}/${PN}-0.74-dont-install-docs.patch"
	sed -i src/parser_rfc822.c -e '/^#define READSIZE/s|16384|32768|' || die
}

src_configure() {
	econf $(use_enable static-libs static)
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

	use static-libs || remove_libtool_files
}
