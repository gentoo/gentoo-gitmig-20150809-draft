# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/edtftpnet/edtftpnet-1.2.5.ebuild,v 1.2 2007/06/26 01:18:33 jurek Exp $

inherit eutils mono

DESCRIPTION="FTP client library for .NET"
HOMEPAGE="http://www.enterprisedt.com/products/edtftpnet/"
SRC_URI="http://www.enterprisedt.com/products/${PN}/download/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc examples"
DEPEND=">=dev-lang/mono-1.2.1
		app-arch/unzip"

RDEPEND="${DEPEND}"

src_install() {
	GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /package ${PN}"
	/usr/bin/gacutil /i ./bin/edtFTPnet.dll ${GACUTIL_FLAGS}

	dodoc readme.html

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
